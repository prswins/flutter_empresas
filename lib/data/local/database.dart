class LoginDB {
  static String tableName = 'login';
  static String id = '_id';
  static String user = 'user';
  static String pwd = 'pwd';
  static String logado = 'logado';

  static String createTable() {
    return '''CREATE TABLE $tableName (
                $id INTEGER PRIMARY KEY,
                $user TEXT NOT NULL,
                $pwd TEXT NOT NULL,
                $logado INTEGER NOT NULL
              )''';
  }

  static String dropTable() {
    return '''DROP TABLE $tableName''';
  }
}

class LoginTokenDB {
  static String tableName = 'loginToken';
  static String id = '_id';
  static String tokenType = 'token_type';
  static String expiresIn = 'expires_in';
  static String accessToken = 'access_token';
  static String uid = 'uid';
  static String client = 'client';
  //static String refreshToken = 'refresh_token';

  static String createTable() {
    return '''CREATE TABLE $tableName (
                $id INTEGER PRIMARY KEY,
                $tokenType TEXT NOT NULL,
                $expiresIn INTEGER NOT NULL,
                $accessToken TEXT NOT NULL,
                $uid TEXT NOT NULL,
                $client TEXT NOT NULL
              )''';
  }

  static String dropTable() {
    return '''DROP TABLE $tableName''';
  }
}
