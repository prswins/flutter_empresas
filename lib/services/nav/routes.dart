import 'package:flutter/material.dart';
import 'package:flutter_empresas/data/response/getEnterpriseListResponse.dart';
import 'package:flutter_empresas/ui/enterprise/enterprise_screen.dart';
import 'package:flutter_empresas/ui/home/home_screen.dart';
import 'package:flutter_empresas/ui/login/login_screen.dart';
import 'package:flutter_empresas/ui/splash/splash_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String enterprise = '/enterprise';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        //var argument = setting.arguments as (tipo);
        // return MaterialPageRoute(settings: RouteSettings(name: settings.name), builder: (context) => LoginScreen(nome_var: argument));
        return MaterialPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (context) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case enterprise:
        return MaterialPageRoute(
            builder: (context) => EnterpriseScreen(
                  empresa: settings.arguments as Enterpris,
                ));
      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) {
            var translate = "";
            return Scaffold(
              body: Center(
                child: Text(translate + ' ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
