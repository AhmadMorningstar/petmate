import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'petmate_admin.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE admin_users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''');
        await db.insert('admin_users', {
          'username': 'Admin',
          'password': '1234',
        });
        await db.insert('admin_users', {
          'username': 'Ahmad',
          'password': 'Ahmad',
        });
      },
    );
  }

  static Future<bool> validateAdmin(String username, String password) async {
    final db = await database;
    final res = await db.query(
      'admin_users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return res.isNotEmpty;
  }

  static Future<void> insertAdmin(String username, String password) async {
    final db = await database;
    await db.insert(
      'admin_users',
      {
        'username': username,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // avoid duplicates
    );
  }
}
