import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = "app_todos.db";
  static const _dbVersion = 1;

  static Database? _database;

  DatabaseHelper._init();

  static Future<Database> get db async {
    _database ??= await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS todos(
            id INTEGER PRIMARY KEY,
            todo TEXT NOT NULL,
            completed INTEGER NOT NULL,
            userId INTEGER NOT NULL
          )
        ''');
      },
    );
  }
}
