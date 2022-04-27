import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empresas/controller/home_controller.dart';
import 'package:flutter_empresas/controller/splash_controller.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/notification/local_notification_service.dart';
import 'package:flutter_empresas/ui/error/error_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_it/get_it.dart';

import 'controller/login_controller.dart';
import 'controller/profile_controller.dart';
import 'services/nav/routes.dart';
import 'util/app_localizations.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<LoginController>(LoginController());
  getIt.registerSingleton<ProfileController>(ProfileController());
  getIt.registerSingleton<HomeController>(HomeController());
  getIt.registerSingleton<SplashController>(SplashController());
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<LocalNotificationService>(LocalNotificationService());
  //getIt.registerSingleton<NotificationService>(NotificationService());

  /* 
   * Ir registrando as instancias abaixo os stores
   * getIt.registerSingleton<Classe>(Classe());
   * Para recuperar a instancia do store nas classes, utilizar dentro do método build da seguinte forma
   * final store = GetIt.I.get<Classe>();
   * 
  */
  // GetIt.I.get<NotificationService>().initFCM();
  GetIt.I.get<LocalNotificationService>().initNotification();
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return widget!;
      },
      title: 'Flutter empresas',
      theme: ThemeData(
        accentColor: Colors.pinkAccent,
        primaryColor: Colors.pink,
        hintColor: Colors.pink,
        primarySwatch: Colors.pink,

      ),
      // debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I<NavigationService>().navigatorKey,
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
      supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: kIsWeb
          ? (locale, supportedLocales) {
              //Para iOS, adicionar os idiomas pelo xcode
              // Verifica se o dispositivo tem suporte dos idiomas
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              // Caso não existe, usa o primeiro, preferencialmente inglês
              return supportedLocales.first;
            }
          : (Platform.isAndroid
              ? (locale, supportedLocales) {
                  //Para iOS, adicionar os idiomas pelo xcode
                  // Verifica se o dispositivo tem suporte dos idiomas
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  // Caso não existe, usa o primeiro, preferencialmente inglês
                  return supportedLocales.first;
                }
              : null),
    );
  }
}
