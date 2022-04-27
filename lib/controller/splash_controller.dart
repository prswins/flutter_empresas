import 'package:dio/dio.dart';
import 'package:flutter_empresas/data/data_manager.dart';
import 'package:flutter_empresas/data/model/login.dart';
import 'package:flutter_empresas/data/model/login_token.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:get_it/get_it.dart';

class SplashController {
  Future checkLogin() async {
    print("checkLogin");
    await DataManager.instance.getCountLogin().then((numLogins) async {
      if (numLogins > 0) {
        await DataManager.instance.getAllLogin().then((allLogins) async {
          for (Login l in allLogins!) {
            if (l.logado) {
              await DataManager.instance
                  .getLastLoginToken()
                  .then((onValue) async {
                // print(onValue!.toJson().toString());
                if (onValue == null) {
                  DataManager.instance
                      .updateDeslogar()
                      .then((value) => goToFirstScreen());
                } else {
                  await DataManager.instance
                      .postLogin(l)
                      .then((response) async {
                    if (response != null && response is Response) {
                      goToMainMenuScreen();
                    } else if (response is DioError) {
                      await DataManager.instance
                          .deleteAll()
                          .then((onValue) async {
                        goToFirstScreen();
                      });
                    }
                  });
                }
              });
            } else {
              if (numLogins == 1) {
                goToFirstScreen();
              }
            }
          }
        });
      } else {
        goToFirstScreen();
      }
    });
  }

  void goToFirstScreen() {
    GetIt.I.get<NavigationService>().navigateTo(Routes.login);
  }

  void goToMainMenuScreen() {
    GetIt.I.get<NavigationService>().navigateTo(Routes.home);
  }
}
