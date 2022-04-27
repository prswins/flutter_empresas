import 'package:mobx/mobx.dart';

part 'login.g.dart';

class Login = _LoginBase with _$Login;

abstract class _LoginBase with Store {
  @observable
  int? id;
  @action
  setId(int? value) => id = value;

  @observable
  bool logado = true;
  @action
  setLogado(bool value) => logado = value;

  @observable
  String user = "";
  @action
  setUser(String value) => user = value;

  @observable
  String pwd = "";
  @action
  setPwd(String value) => pwd = value;

  Login fromJson(Map<String, dynamic> json) => Login()
    ..setId(json["_id"])
    ..setUser(json["user"])
    ..setPwd(json["pwd"])
    ..setLogado(json["logado"] == 1 ? true : false);

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "pwd": pwd == null ? null : pwd,
        "logado": logado ? 1 : 0,
      };
}
// import 'dart:convert';

// Login loginFromJson(String str) => Login.fromJson(json.decode(str));

// String loginToJson(Login data) => json.encode(data.toJson());

// class Login {
//     String user;
//     String pwd;

//     Login({
//         this.user,
//         this.pwd,
//     });

//     factory Login.fromJson(Map<String, dynamic> json) => new Login(
//         user: json["user"] == null ? null : json["user"],
//         pwd: json["pwd"] == null ? null : json["pwd"],
//     );

//     Map<String, dynamic> toJson() => {
//         "user": user == null ? null : user,
//         "pwd": pwd == null ? null : pwd,
//     };

// }