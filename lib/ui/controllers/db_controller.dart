import 'dart:async';
import 'dart:math';
import 'package:exercise_tracker/models/trayectory_point.dart';
import 'package:exercise_tracker/models/user_model.dart';
import 'package:loggy/loggy.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  static final DatabaseController instance = DatabaseController._init();
  static Database? _database;

  DatabaseController._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('exercise_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        email TEXT PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        password TEXT NOT NULL,
        gender TEXT NOT NULL,
        profile_image_url TEXT NOT NULL,
        date_of_birth INTEGER NOT NULL,
        weight REAL NOT NULL,
        height REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        speed_km_h REAL NOT NULL,
        position_latitude REAL NOT NULL,
        position_longitude REAL NOT NULL,
        distance_between_last_position REAL NOT NULL,
        accumulated_distance REAL NOT NULL,
        accumulated_elapsed_time TEXT NOT NULL,
        FOREIGN KEY (user_email) REFERENCES users(email)
      )
    ''');
  }

  Future<User?> getUser(String email) async {
    final db = await database;
    final maps = await db.query('users',
        columns: null, where: 'email = ?', whereArgs: [email]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update('users', user.toJson(),
        where: 'email = ?', whereArgs: [user.email]);
  }

  Future<int> deleteUser(User user) async {
    final db = await database;
    return await db.delete('users',
        where: 'email = ?', whereArgs: [user.email]);
  }

  Future<List<TrayectoryMetadata>> getHistory(User user) async {
    final db = await database;
    final maps = await db.query('history',
        columns: null, where: 'user_email = ?', whereArgs: [user.email]);

    return List.generate(maps.length, (i) {
      return TrayectoryMetadata.fromJson(maps[i]);
    });
  }

Future<int> insertHistory(TrayectoryMetadata metadata) async {
  final db = await database;

  // insert the associated user if it doesn't exist
  if (await getUser(metadata.user.email) == null) {
    await insertUser(metadata.user);
  }

  return await db.transaction((txn) async {
    int id = -1;

    try {
      id = await txn.insert('history', metadata.toJson());
    } catch (e) {
      
    }

    return id;
  });
}



  Future<int> deleteHistory(int id) async {
  final db = await instance.database;
  return await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }


}
