import 'dart:convert';

LoginToken loginTokenFromJson(String str) =>
    LoginToken.fromJson(json.decode(str));

String loginTokenToJson(LoginToken data) => json.encode(data.toJson());

class LoginToken {
  String tokenType;
  int expiresIn;
  String accessToken;
  String uid;
  String client;
  

  LoginToken({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.uid,
    required this.client
 
  }) : super();

  factory LoginToken.fromJson(Map<String, dynamic> json) => new LoginToken(
        tokenType: json["token_type"] == null ? null : json["token_type"],
        expiresIn: json["expires_in"] == null ? null : json["expires_in"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        uid: json["uid"] == null ? null : json["uid"],
        client: json["client"] == null ? null : json["client"]
        
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType == null ? null : tokenType,
        "expires_in": expiresIn == null ? null : expiresIn,
        "access_token": accessToken == null ? null : accessToken,
        "uid": uid == null ? null : uid,
        "client": client == null ? null : client
        
      };
}
