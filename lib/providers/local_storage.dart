import 'package:bloc_project/utiles/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage extends ChangeNotifier {
  Database? _database;
  final String dbname = "blocapp.db";

  void log(String? funcName, String message) {
    logger('LocalStorage', funcName, message);
  }

  Future<void> _initialize(Database db) async {
    // await db.execute('''CREATE TABLE ''');
    await db.execute('''CREATE TABLE KeepBook (id INTEGER PRIMARY KEY, name TEXT)''');
    await db.execute('''INSERT INTO KeepBook (id, name) VALUES (0,'Your KeepBook')''');
    return;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }

    try {
      _database = await openDatabase(join(await getDatabasesPath(), dbname), version: 1,
          onCreate: (Database db, int version) {
        _initialize(db);
      }, onOpen: (Database db) {
        log('getDatabase', 'Database opened');
      });
      notifyListeners();
      return _database!;
    } catch (error) {
      log('getDatabase', 'Error occurred: $error');
      return null;
    }
  }
}
