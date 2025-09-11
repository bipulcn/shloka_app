import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slokas/data/models/shlokas.dart';
import 'package:sqflite/sqflite.dart';

// import 'slokas.dart';

class ShlokaDatabase {
  static final ShlokaDatabase instance = ShlokaDatabase._init();
  static Database? _database;

  ShlokaDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("shlokas.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String dbPath = join(docsDir.path, filePath);
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shlokas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        kinds TEXT NOT NULL,
        serial INTEGER NOT NULL,
        sanskrit TEXT,
        bengali TEXT,
        english TEXT,
        meaning TEXT,
        wordMeaning TEXT,
        viewed INTEGER,
        learnt INTEGER,
        difficultyLevel INTEGER,
        lastReadDate TEXT,
        numberOfTimeRead INTEGER,
        firstReadDate TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE words (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sanskrit TEXT,
        bengali TEXT,
        english TEXT,
        pronounce TEXT,
        viewed INTEGER,
        learnt INTEGER,
        numberOfTimeRead INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE tracks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kinds TEXT,
        page INTEGER,
        prev INTEGER,
        next INTEGER,
        numberOfTimeRead INTEGER
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
