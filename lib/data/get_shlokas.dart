import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:slokas/data/models/shlokas.dart';
import 'package:slokas/data/models/words.dart';
import 'package:slokas/data/shloka_database.dart';
import 'package:sqflite/sqflite.dart';

class GetShloka {
  Future<Database> get _db async => await ShlokaDatabase.instance.database;

  Future<void> insertShort() async {
    final db = await _db;

    // Check if table is empty
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM shlokas where kinds='short'"),
    );

    if (count == 0) {
      // Load JSON file from assets
      final String response = await rootBundle.loadString(
        'assets/data/short_shlokas.json',
      );
      final List<dynamic> data = jsonDecode(response);

      for (var item in data) {
        await db.insert('shlokas', ShlokaModel.fromJson(item).toJson());
      }
    }
  }

  Future<void> insertLong() async {
    final db = await _db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM shlokas where kinds='long'"),
    );

    if (count == 0) {
      final String response = await rootBundle.loadString(
        'assets/data/long_shlokas.json',
      );
      final List<dynamic> data = jsonDecode(response);

      for (var item in data) {
        await db.insert('shlokas', ShlokaModel.fromJson(item).toJson());
      }
    }
  }

  Future<void> insertGita() async {
    final db = await _db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM shlokas where kinds='gita'"),
    );

    if (count == 0) {
      final String response = await rootBundle.loadString(
        'assets/data/gita_shlokas.json',
      );
      final List<dynamic> data = jsonDecode(response);

      for (var item in data) {
        await db.insert('shlokas', ShlokaModel.fromJson(item).toJson());
      }
    }
  }

  Future<void> words() async {
    final db = await _db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM words"),
    );

    if (count == 0) {
      final String response = await rootBundle.loadString(
        'assets/data/words.json',
      );
      final List<dynamic> data = jsonDecode(response);

      for (var item in data) {
        await db.insert('words', Word.fromJson(item).toJson());
      }
    }
  }

  Future<List<ShlokaModel>> getAllShlokas() async {
    final db = await _db;
    final result = await db.query('shlokas');
    return result.map((e) => ShlokaModel.fromJson(e)).toList();
  }

  Future<List<ShlokaModel>> getShlokaByCat(String cat) async {
    final db = await _db;
    final result = await db.query(
      'shlokas',
      where: 'kinds = ?',
      whereArgs: [cat],
    );
    return result.map((e) => ShlokaModel.fromJson(e)).toList();
  }

  Future<int> insertShloka(ShlokaModel shloka) async {
    final db = await _db;
    return await db.insert('shlokas', shloka.toJson());
  }
}
