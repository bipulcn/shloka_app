import 'package:slokas/data/models/words.dart';
import 'package:slokas/data/shloka_database.dart';
import 'package:sqflite/sqflite.dart';

class GetWords {
  Future<Database> get _db async => await ShlokaDatabase.instance.database;
  // Create a new word
  Future<int> createWord(Word word) async {
    final db = await _db;
    return await db.insert('words', word.toMap());
  }

  // Read all words
  Future<List<Word>> readAllWords() async {
    final db = await _db;
    final result = await db.query('words', orderBy: 'pronounce ASC');
    return result.map((json) => Word.fromJson(json)).toList();
  }

  // Read a single word by id
  Future<Word?> readWord(int id) async {
    final db = await _db;
    final result = await db.query('words', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Word.fromMap(result.first) : null;
  }

  // Update a word
  Future<int> updateWord(Word word) async {
    final db = await _db;
    return await db.update(
      'words',
      word.toMap(),
      where: 'id = ?',
      whereArgs: [word.id],
    );
  }

  // Delete a word
  Future<int> deleteWord(int id) async {
    final db = await _db;
    return await db.delete('words', where: 'id = ?', whereArgs: [id]);
  }

  // Mark word as viewed
  Future<int> markAsViewed(int id) async {
    final db = await _db;
    return await db.rawUpdate(
      '''
      UPDATE words 
      SET viewed = viewed + 1 
      WHERE id = ?
    ''',
      [id],
    );
  }

  // Mark word as learnt
  Future<int> markAsLearnt(int id) async {
    final db = await _db;
    return await db.rawUpdate(
      '''
      UPDATE words 
      SET learnt = 1 
      WHERE id = ?
    ''',
      [id],
    );
  }

  // Increment read count
  Future<int> incrementReadCount(int id) async {
    final db = await _db;
    return await db.rawUpdate(
      '''
      UPDATE words 
      SET numberOfTimeRead = numberOfTimeRead + 1 
      WHERE id = ?
    ''',
      [id],
    );
  }

  // Get words by viewed status
  Future<List<Word>> getWordsByViewedStatus(bool viewed) async {
    final db = await _db;
    final result = await db.query(
      'words',
      where: 'viewed = ?',
      whereArgs: [viewed ? 1 : 0],
    );
    return result.map((json) => Word.fromMap(json)).toList();
  }

  // Get learnt words
  Future<List<Word>> getLearntWords() async {
    final db = await _db;
    final result = await db.query('words', where: 'learnt = ?', whereArgs: [1]);
    return result.map((json) => Word.fromMap(json)).toList();
  }

  // Search words
  Future<List<Word>> searchWords(String query) async {
    final db = await _db;
    final result = await db.query(
      'words',
      where: 'sanskrit LIKE ? OR bengali LIKE ? OR english LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return result.map((json) => Word.fromMap(json)).toList();
  }
}
