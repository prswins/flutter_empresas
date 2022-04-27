import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_empresas/controller/splash_controller.dart';
import 'package:flutter_empresas/services/nav/navigation_service.dart';
import 'package:flutter_empresas/services/nav/routes.dart';
import 'package:flutter_empresas/ui/widgets/background_splash.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = GetIt.I.get<SplashController>();
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () async {
      return await GetIt.I.get<NavigationService>().navigateTo(Routes.login);
    }, 
      child: Scaffold(
        
        body: Stack(
          children: [
            BackgroundSplash(),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  'assets/logo.png',
                  color: Colors.white,
                  scale: 2,
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
