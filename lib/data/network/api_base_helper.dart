import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiBaseHelper {
  static final String dev_host = "https://empresas.ioasys.com.br";
  static final String api_version = "v1";
  static final String url = "${dev_host}/api/${api_version}";
  static final String _endpoint = url;
  static const platform = const MethodChannel('flutter.native/helper');

  Dio _dio = new Dio();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Singleton
  ApiBaseHelper._privateConstructor();
  static final ApiBaseHelper instance = ApiBaseHelper._privateConstructor();

  Future<Dio> getDio() async {
    _dio = new Dio();
    _dio.options.baseUrl = _endpoint;
    if (!kIsWeb) {
      String proxy = await getProxy();
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return (proxy != null && proxy != "") ? "PROXY $proxy" : 'DIRECT';
        };

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _dio.options.headers.addAll({
          "dispositivonome": "${androidInfo.manufacturer} ${androidInfo.model}"
        });
        _dio.options.headers.addAll({
          "dispositivoos":
              "${androidInfo.version.baseOS} ${androidInfo.version.release} ${androidInfo.version.sdkInt}"
        });
        _dio.options.headers.addAll({"dispositivouuid": androidInfo.androidId});
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _dio.options.headers
            .addAll({"dispositivonome": iosInfo.utsname.machine});
        _dio.options.headers.addAll({
          "dispositivoos": "${iosInfo.systemName} ${iosInfo.systemVersion}"
        });
        _dio.options.headers
            .addAll({"dispositivouuid": iosInfo.identifierForVendor});
      }
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _dio.options.headers
          .addAll({"dispositivoappversao": packageInfo.buildNumber});
    }

    _dio.interceptors.add(PrettyDioLogger());
    return _dio;
  }

  Future<String> getProxy() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('getProxy');
      print(result);
      response = result;
    } catch (e) {
      print(e);
      response = "";
    }
    return response;
  }
}
