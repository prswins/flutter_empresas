import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class DatabaseHelper {
  // Arquivo do DB.
  static final _databaseName = "appdatabase.db";
  // Incrementar para alterar a versão do 'schema'.
  static final _databaseVersion = 3;

  // Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Conexão unica.
  late Database? _database;
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  // Abre o DB
  _initDatabase() async {
    // Caminho para Android/iOS
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    createTables(db);
  }

  void createTables(Database db) {
    db.execute(LoginTokenDB.createTable());
    db.execute(LoginDB.createTable());
  }

  void dropTables(Database db) {
    db.execute(LoginTokenDB.dropTable());
    db.execute(LoginDB.dropTable());
  }

  Future _onUpgrade(Database db, int newVersion, int oldVersion) async {
    //Apaga tudo e recria
    dropTables(db);
    createTables(db);
  }
}
