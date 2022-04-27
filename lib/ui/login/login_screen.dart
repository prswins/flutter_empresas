import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:flutter_empresas/ui/widgets/background_splash.dart';
import 'package:flutter_empresas/util/colorUtil.dart';
import 'package:flutter_empresas/util/dialogUtil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get_it/get_it.dart';

import '../../controller/login_controller.dart';
import '../../util/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = GetIt.I.get<LoginController>();

  _textField({String? labelText, onChanged, String? errorText}) {
    return TextField(
        style: TextStyle(color: ColorUtil.primaryText),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          errorText: errorText == null ? null : errorText,
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onFocusLost: () {
          print("onPause viewDidDisappear Login");
        },
        onFocusGained: () {
          print("onResume viewDidAppear Login");
          //GetIt.I.get<NotificationService>().setPage(Routes.login);
        },
        child: Scaffold(
          body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    bottom: -MediaQuery.of(context).viewInsets.bottom,
                    child: Container()),
                Observer(
                  builder: (_) {
                    switch (controller.stateLogin) {
                      case LoginState.LOADING:
                        return Stack(
                          children: [
                            BackgroundSplash(),
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        );

                      case LoginState.SUCCESS:
                      case LoginState.FAIL:
                      case LoginState.IDLE:
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            BackgroundSplash(),
                            SingleChildScrollView(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/logo.png',
                                        scale: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    //"Bem vindo,",
                                    AppLocalizations.tl('t_welcome_1_login'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    //"Você está no empresas",
                                    AppLocalizations.tl('t_welcome_2_login'),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Observer(
                                          builder: (_) {
                                            return _textField(
                                              errorText: controller
                                                          .validateUser !=
                                                      null
                                                  ? AppLocalizations.tl(
                                                      controller.validateUser)
                                                  : null,
                                              labelText: AppLocalizations.tl(
                                                  'tf_user'),
                                              onChanged:
                                                  controller.login.setUser,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Observer(
                                          builder: (_) {
                                            return _textField(
                                                errorText: controller
                                                            .validatePwd !=
                                                        null
                                                    ? AppLocalizations.tl(
                                                        controller.validatePwd)
                                                    : null,
                                                labelText: AppLocalizations.tl(
                                                    'tf_pwd'),
                                                onChanged:
                                                    controller.login.setPwd);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Observer(
                                          builder: (_) {
                                            return Container(
                                              height: 52.0,
                                              margin: EdgeInsets.all(15),
                                              child: ElevatedButton(
                                                onPressed: controller.isValid
                                                    ? () {
                                                        controller
                                                            .postLogin()
                                                            .then((onValue) {
                                                          if (onValue is bool) {
                                                            //redireciona
                                                            GetIt.I
                                                                .get<
                                                                    NavigationService>()
                                                                .navigateTo(
                                                                    Routes
                                                                        .home);
                                                          } else if (onValue
                                                              is String) {
                                                            print("erro login");
                                                            DialogUtil
                                                                .showFieldsErrorDialog(
                                                                    message:
                                                                        onValue);
                                                          }
                                                        });
                                                      }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 3,
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0))),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                      color: ColorUtil.primary,
                                                      border: Border.all(
                                                          color: ColorUtil
                                                              .primary),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        minHeight: 52.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      AppLocalizations.tl(
                                                              'bt_login')
                                                          .toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
