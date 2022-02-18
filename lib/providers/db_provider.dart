import 'dart:async';
import 'package:netroll/models/Dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  final String tableName = 'dogs';
  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB();
    if (_db == null) {
      throw Error();
    } else {
      return _db as Database;
    }
  }

  Future<Database> _initDB() async {
    var path = join(await getDatabasesPath(), 'doggie_database.db');
    // await deleteDatabase(path); // if not persist
    final database = openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'CREATE Table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, created_at TEXT, edited_at TEXT)');
      },
      version: 1,
    );

    return database;
  }

  Future<List<Dog>> loadAll() async {
    final db = await database;
    var maps = await db.query(tableName, orderBy: 'created_at ASC');
    if (maps.isEmpty) return [];

    return maps.map((json) => Dog.fromMap(json)).toList();
  }

  Future<int> insert(Dog dog) async {
    final db = await database;
    return await db.insert(tableName, dog.toMap());
  }

  Future<int> delete(Dog dog) async {
    final db = await database;
    if (dog.id == null) {
      throw Exception('this dog doesn\'t have id');
    }
    return await db.delete(tableName, where: 'id = ?', whereArgs: [dog.id]);
  }
}
