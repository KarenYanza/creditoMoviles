import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('login.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE login (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        fingerprint INTEGER
      )
    ''');
  }

  Future<void> saveLogin(
      String username, String password, bool fingerprint) async {
    final db = await instance.database;
    await db.insert(
      'login',
      {
        'username': username,
        'password': password,
        'fingerprint': fingerprint ? 1 : 0,
      },
    );
  }

  Future<Map<String, dynamic>?> getLogin() async {
    final db = await instance.database;
    final result = await db.query('login', orderBy: 'id DESC', limit: 1);

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }
}
