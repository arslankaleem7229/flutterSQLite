import 'dart:async';
import 'dart:io';

import 'package:fluttersqlite/models/Users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String table = "userTable";
  final String columnId = "id";
  final String columnName = "username";
  final String columnPassword = "password";

  static final DataBaseHelper databseshelper = new DataBaseHelper.internal();

  factory DataBaseHelper() => databseshelper;

  static Database _database;

  Future<Database> get database async {
    if (database != null) {
      return _database;
    } else {
      _database = await initdb();
      return _database;
    }
  }

  DataBaseHelper.internal();

  initdb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");
    print(path);
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table($columnId INTERGER PRIMARY KEY, $columnName TEXT , $columnPassword TEXT)");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await database;
    int res = await dbClient.insert("$table", user.toMap());
    return res;
  }

  Future<List> getAllUsers() async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $table");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await database;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery("SELECT COUNT(*) FROM $table"),
    );
  }

  Future<User> getUser(int index) async {
    var dbClient = await database;
    var result = await dbClient
        .rawQuery("SELECT * FROM $table WHERE $columnId = $index");
    if (result.length == 0) {
      return null;
    } else {
      new User.fromMap(result.first);
    }
  }

  Future<int> deleteUser(int index) async {
    var dbClient = await database;
    return await dbClient
        .delete("$table", where: "$columnId = ?", whereArgs: [index]);
  }
}
