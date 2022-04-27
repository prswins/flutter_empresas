import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import 'local/database.dart';
import 'local/database_helper.dart';
import 'model/login.dart';
import 'model/login_token.dart';
import 'network/api_base_helper.dart';

class DataManager {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper.instance;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // Singleton
  DataManager._privateConstructor();
  static final DataManager instance = DataManager._privateConstructor();

  // START LOGIN
  Future<dynamic> postLogin(Login login) async {
    try {
      Map<String, dynamic> body = {
        'email': login.user,
        'password': login.pwd,
        //'client_id': ApiBaseHelper.client_id,
        //'client_secret': ApiBaseHelper.client_secret,
        //'grant_type': 'password',
        // "scope": "*"
      };
      Dio dio = await _apiBaseHelper.getDio();
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';

      Response response = await dio.post("/users/auth/sign_in", data: body);
      if (response.statusCode == 200) {
        String? accessToken;
        String? uid;
        String? client;
        int? expiry;
        String? tokenType;
        response.headers.forEach((name, values) {
          if (name.contains("token-type")) tokenType = values.first;
          if (name.contains("access-token")) accessToken = values.first;
          if (name.contains("expiry")) expiry = int.parse(values.first);
          if (name.contains("client")) client = values.first;
          if (name.contains("uid")) uid = values.first;
        });
        await getAllLogin().then((value) async {
          if (value!.length > 0) {
            value.forEach((element) async {
              if (element.user != login.user) {
                await updateDeslogar();
              } else {
                login.setLogado(true);
                await updateLogin(login);
              }
            });
          } else {
            login.setLogado(true);
            await insertLogin(login);
          }
        });

        await deleteAll().then((value) async => insert(LoginToken(
              tokenType: tokenType!,
              expiresIn: expiry!,
              accessToken: accessToken!,
              uid: uid!,
              client: client!,
            )));
      }
      return response;
    } on DioError catch (e) {
      return e;
    }
  }

  Future<int> insertLogin(Login login) async {
    Database db = await _databaseHelper.database;
    Map<String, dynamic> row = {
      LoginDB.user: login.user,
      LoginDB.pwd: login.pwd,
      LoginDB.logado: login.logado ? 1 : 0,
    };
    print("INSERT");
    print(row);
    int id = await db.insert(LoginDB.tableName, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> updateLogin(Login login) async {
    Database db = await _databaseHelper.database;
    Map<String, dynamic> row = {
      LoginDB.user: login.user,
      LoginDB.pwd: login.pwd,
      LoginDB.logado: login.logado ? 1 : 0,
    };
    print("UPDATE");
    print(row);
    return await db.update(LoginDB.tableName, row,
        where: 'user = ?', whereArgs: [login.user]);
  }

  Future<List<Login>?> getAllLogin() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query(LoginDB.tableName);
    if (maps.length > 0) {
      print("get all logins");
      print(maps);
      List<Login> logins = [];
      maps.forEach((map) {
        Login l = Login().fromJson(map);
        logins.add(l);
      });
      return logins;
    }
    return [];
  }

  Future<int> updateDeslogar() async {
    Database db = await _databaseHelper.database;
    Map<String, dynamic> row = {
      LoginDB.logado: 0,
    };
    print("UPDATE DESLOGAR");
    print(row);
    return await db
        .update(LoginDB.tableName, row, where: 'logado = ?', whereArgs: [1]);
  }

  Future<int> deleteLogin(Login login) async {
    Database db = await _databaseHelper.database;
    return await db
        .delete(LoginDB.tableName, where: '_id = ?', whereArgs: [login.id]);
  }

  Future<int> deleteAllLogin() async {
    Database db = await _databaseHelper.database;
    int id = await db.delete(LoginDB.tableName);
    return id;
  }

  Future<int> getCountLogin() async {
    Database db = await _databaseHelper.database;
    List<Map> maps = await db.query(LoginDB.tableName);
    return maps.length;
  }

  Future<Login?> getLastLogin() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> tokens = await db.query(LoginDB.tableName);
    if (tokens.length > 0) {
      return Login().fromJson(tokens.last);
    }
    return null;
  }
  // END LOGIN

  // START LOGIN TOKEN
  Future<int> insert(LoginToken loginToken) async {
    Database db = await _databaseHelper.database;
    int id = await db.insert(LoginTokenDB.tableName, loginToken.toJson());
    return id;
  }

  Future<LoginToken?> getLoginTokenById(int _id) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> tokens = await db.query(LoginTokenDB.tableName,
        columns: [
          LoginTokenDB.id,
          LoginTokenDB.tokenType,
          LoginTokenDB.expiresIn,
          LoginTokenDB.accessToken,
          LoginTokenDB.uid,
          LoginTokenDB.client
        ],
        where: '${LoginTokenDB.id} = ?',
        whereArgs: [_id]);
    if (tokens.length > 0) {
      return LoginToken.fromJson(tokens.first);
    }
    return null;
  }

  Future<List<LoginToken>?> getAllLoginToken() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query(LoginTokenDB.tableName);
    if (maps.length > 0) {
      List<LoginToken> logins = [];
      maps.forEach((map) => logins.add(LoginToken.fromJson(map)));
      return logins;
    }
    return null;
  }

  Future<LoginToken?> getLastLoginToken() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> tokens = await db.query(LoginTokenDB.tableName);
    if (tokens.length > 0) {
      return LoginToken.fromJson(tokens.last);
    }
    return null;
  }

  Future<int> update(LoginToken loginToken) async {
    Database db = await _databaseHelper.database;
    return await db.update(LoginTokenDB.tableName, loginToken.toJson());
  }

  Future<int> deleteAll() async {
    Database db = await _databaseHelper.database;
    int id = await db.delete(LoginTokenDB.tableName);
    return id;
  }

  // END LOGIN TOKEN
  Future<dynamic> getEmpresaConsultar(
      {required String nome, required String? type}) async {
    try {
      Dio dio = await _apiBaseHelper.getDio();
      String accessToken = "";
      String client = "";
      String uid = "";
      String tokenType = "";
      await getLastLoginToken().then((onValue) {
        accessToken = onValue!.accessToken;
        client = onValue.client;
        uid = onValue.uid;
        tokenType = onValue.tokenType;
      });
      dio.options.headers['Token-Type'] = tokenType;
      dio.options.headers['access-token'] = accessToken;
      dio.options.headers['client'] = client;
      dio.options.headers['uid'] = uid;

      dio.options.headers['Accept'] = 'application/json';
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
      print(dio.options.headers);
      Response response;
      if (type == null)
        response = await dio.get("/enterprises", queryParameters: {
          "name": nome,
        });
      else
        response = await dio.get("/enterprises", queryParameters: {
          "enterprise_types": type,
          "name": nome,
        });
      print(response.realUri);
      return response;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {}
      return e;
    }
  }
}
