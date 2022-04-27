import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_empresas/controller/profile_controller.dart';
import 'package:flutter_empresas/data/model/login_token.dart';
import 'package:flutter_empresas/data/response/postLoginResponse.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';

import '../data/data_manager.dart';
import '../data/model/login.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

abstract class _LoginControllerBase with Store {
  var login = Login();

  @observable
  List<Login> loginList = [];

  @action
  setLoginList(List<Login> list) => loginList = list;

  @observable
  LoginState stateLogin = LoginState.IDLE;
  @action
  setStateLogin(LoginState state) => stateLogin = state;

  @computed
  bool get isValid => validatePwd == null && validateUser == null;

  @computed
  get validateUser {
    if (login.user == null || login.user.isEmpty) {
      return 'error_user_empty';
    } else if (login.user.length < 3) {
      return 'error_user_short';
    }
    return null;
  }

  @computed
  get validatePwd {
    if (login.pwd == null || login.pwd.isEmpty) {
      return 'error_pwd_empty';
    }
    return null;
  }

  Future postLogin() {
    setStateLogin(LoginState.LOADING);
    return DataManager.instance.postLogin(login).then((response) async {
      print(response);
      if (response != null && response is Response) {
        PostLoginResponse usuario = PostLoginResponse.fromJson(response.data);
        GetIt.I.get<ProfileController>().setUsuario(usuario);
        print("usuario.toJson()");

        await loadLoginList().then((value) async {
          for (Login l in value) {
            print("Login controller");
            print(l.user);
            print(login.user);
            if (l.user == login.user) {
              await DataManager.instance.updateLogin(l..setLogado(true));
              return;
            } else {
              await DataManager.instance.updateLogin(l..setLogado(false));
            }
          }
        });
      } else {
        DioError e = response;
        setStateLogin(LoginState.IDLE);
     
        return e.response!.statusMessage;
      }
      login.setUser("");
      login.setPwd("");
      //tratar o resultado
      await new Future.delayed(const Duration(seconds: 3));
      setStateLogin(LoginState.IDLE);
      return true;
    });
  }

  Future loadLoginList() {
    return DataManager.instance.getAllLogin().then((value) {
      setLoginList(value!);

      return loginList;
    });
  }

  Future? checkLogin({bool? force}) {
    return DataManager.instance.getAllLogin().then((list) {
      if (list!.length == 0) {
      } else {
        setLoginList(list);
        for (Login l in list) {
          if (l.logado) {
            login = l;

            postLoginList(l).then((onValue) {
              if (onValue is bool) {
                GetIt.I.get<NavigationService>().navigateTo(Routes.home);
              }
            });
            return;
          }
        }
      }
    });
  }

  Future postLoginList(Login l) {
    setStateLogin(LoginState.LOADING);

    return DataManager.instance.postLogin(l).then((response) async {
      if (response != null && response is Response) {
        Map<String, dynamic> resposta = response.data;
        if (resposta.containsKey("erros")) {
          setStateLogin(LoginState.FAIL);
          return resposta["erros"];
        }

        LoginToken respostaLogin = LoginToken.fromJson(resposta);

        l.logado = true;
        l.pwd = "";
        login = l;
        await DataManager.instance.updateLogin(l).then((_) async {
          await DataManager.instance.deleteAll().then((onValue) async {
            await DataManager.instance.insert(respostaLogin).then((value) {
              GetIt.I.get<NavigationService>().navigateTo(Routes.home);
            });
          });
        });
        setStateLogin(LoginState.SUCCESS);

        return true;
      } else if (response is DioError) {
        setStateLogin(LoginState.FAIL);

        var r = json.decode(response.response.toString());
        return r["message"];
      }
    });
  }
}
