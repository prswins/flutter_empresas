import 'package:flutter/material.dart';
import 'package:flutter_empresas/controller/login_controller.dart';
import 'package:flutter_empresas/data/data_manager.dart';
import 'package:flutter_empresas/data/model/login.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:flutter_empresas/services/notification/local_notification_service.dart';
import 'package:flutter_empresas/ui/widgets/rounded_button.dart';
import 'package:get_it/get_it.dart';
import 'app_localizations.dart';
import 'colorUtil.dart';

class DialogUtil {
  static showFieldsErrorDialog({String? message}) {
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('warning')),
          content: new Text((message == null
              ? AppLocalizations.tl('error_verify')
              :
              //AppLocalizations.tl(message)
              message)),
          actions: <Widget>[
            // define os botões na base do dialogo
            new ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorUtil.primary)),
              child: new Text(
                AppLocalizations.tl('close'),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showDefaultDialogCenter(
      {String? title,
      String? message,
      List<RoundedButton>? listaBotoes}) async {
    await showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(
            title!,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(message!),
                listaBotoes != null && listaBotoes.length > 0
                    ? Column(
                        children: listaBotoes,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    : new ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: new Text(
                          AppLocalizations.tl('close'),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  static showListErrorsDialog(List<String> list) {
    String message = "";
    for (String s in list) {
      message += "${s}\n";
    }
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('warning')),
          content: new Text(message),
          actions: <Widget>[
            // define os botões na base do dialogo
            new ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: new Text(
                AppLocalizations.tl('close'),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static logout() {
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('logout_title')),
          content: new Text(AppLocalizations.tl('logout_content')),
          actions: <Widget>[
            // define os botões na base do dialogo
            new RoundedButton(
              maxWidthWidget: 90,
              callback: () => Navigator.of(context).pop(),
              text: AppLocalizations.tl('cancel'),
              // "cancelar",
              isPrimaryColor: false,
            ),
            new RoundedButton(
                maxWidthWidget: 90,
                text: AppLocalizations.tl('logout_confirm'),
                //"confirmar",
                callback: () {
                  DataManager.instance.updateDeslogar().then((value) {
                    DataManager.instance.deleteAll().then((value) {
                      Navigator.of(context).pop();
                      GetIt.I.get<LocalNotificationService>().showNotification(
                          0,
                          AppLocalizations.tl('t_msg_logout'),
                          AppLocalizations.tl('t_msg_logout2'),
                          //"Volte sempre",
                         //"Obrigado por utilizar o Empresas",
                          3);
                      GetIt.I
                          .get<NavigationService>()
                          .navigateTo(Routes.splash);
                    });
                  });
                },
                isPrimaryColor: true)
          ],
        );
      },
    );

    // await DataManager.instance.deleteAll()
  }

  static emailEmpty() {
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('t_dialog_email_empty_title')
              //"Digite um email para continuar"
              ),
          //content: new Text(AppLocalizations.tl('logout_content')),
          actions: <Widget>[
            // define os botões na base do dialogo
            new ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: new Text(
                AppLocalizations.tl('close'),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static codigoEmpty() {
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('t_dialog_codigo_empty_title')
              //"Digite o código para continuar"
              ),
          content: new Text(AppLocalizations.tl('t_dialog_codigo_empty_content')
              //"Verifique sua caixa de entrada de email ou solicite o reenvio do código"
              ),
          actions: <Widget>[
            // define os botões na base do dialogo
            new ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: new Text(
                AppLocalizations.tl('close'),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static passwordEmpty() {
    showDialog(
      context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(AppLocalizations.tl('t_dialog_password_empty_title')
              //"Digite o código para continuar"
              ),
          /*content: new Text(
              AppLocalizations.tl('t_dialog_codigo_empty_content')
              //"Verifique sua caixa de entrada de email ou solicite o reenvio do código"
              ),*/
          actions: <Widget>[
            // define os botões na base do dialogo
            new ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: new Text(
                AppLocalizations.tl('close'),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showDeleteUserDialog(Login l, LoginController controller) {
    showDialog(
        context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "${AppLocalizations.tl('t_login_delete')}${l.user}?",
            ),
            actions: [
              new RoundedButton(
                maxWidthWidget: 90,
                callback: () => Navigator.of(context).pop(),
                text: AppLocalizations.tl('cancel'),
                isPrimaryColor: false,
              ),
              new RoundedButton(
                  maxWidthWidget: 90,
                  text: AppLocalizations.tl('confirm'),
                  callback: () {
                    DataManager.instance
                        .deleteLogin(l)
                        .then((value) => controller.checkLogin());
                    Navigator.of(context).pop();
                  },
                  isPrimaryColor: true)
            ],
          );
        });
  }

  static showLoginListDialog(Login l, LoginController controller) {
    String pwd = "";
    showDialog(
        context: GetIt.I.get<NavigationService>().navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "${AppLocalizations.tl('t_login_list_pwd')}${l.user}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) => pwd = value,
                ),
                Wrap(
                  children: [
                    new RoundedButton(
                      maxWidthWidget: 90,
                      callback: () => Navigator.of(context).pop(),
                      text: AppLocalizations.tl('cancel'),
                      isPrimaryColor: false,
                    ),
                    new RoundedButton(
                        maxWidthWidget: 90,
                        text: AppLocalizations.tl('confirm'),
                        callback: () {
                          controller.postLoginList(l..setPwd(pwd));
                          Navigator.of(context).pop();
                        },
                        isPrimaryColor: true)
                  ],
                )
              ],
            ),
          ));
        });
  }
}
