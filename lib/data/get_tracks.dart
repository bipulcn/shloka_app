import 'package:slokas/data/models/tracks.dart';
import 'package:slokas/data/shloka_database.dart';
import 'package:sqflite/sqflite.dart';

class GetTracks {
  Future<Database> get _db async => await ShlokaDatabase.instance.database;
  // Create a new track
  Future<int> createTrack(Track track) async {
    final db = await _db;
    return await db.insert('tracks', track.toMap());
  }

  // Read all tracks
  Future<List<Track>> readAllTracks() async {
    final db = await _db;
    final result = await db.query('tracks', orderBy: 'page ASC');
    return result.map((json) => Track.fromMap(json)).toList();
  }

  // Read a single track by id
  Future<Track?> readTrack(int id) async {
    final db = await _db;
    final result = await db.query('tracks', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Read tracks by kind/category
  Future<List<Track>> readTracksByKind(String kind) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'kinds = ?',
      whereArgs: [kind],
      orderBy: 'page ASC',
    );
    return result.map((json) => Track.fromMap(json)).toList();
  }

  // Read track by page number
  Future<Track?> readTrackByPage(int page) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'page = ?',
      whereArgs: [page],
    );
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Update a track
  Future<int> updateTrack(Track track) async {
    final db = await _db;
    return await db.update(
      'tracks',
      track.toMap(),
      where: 'id = ?',
      whereArgs: [track.id],
    );
  }

  // Delete a track
  Future<int> deleteTrack(int id) async {
    final db = await _db;
    return await db.delete('tracks', where: 'id = ?', whereArgs: [id]);
  }

  // Increment read count
  Future<int> incrementReadCount(int id) async {
    final db = await _db;
    return await db.rawUpdate(
      '''
      UPDATE tracks 
      SET numberOfTimeRead = numberOfTimeRead + 1 
      WHERE id = ?
    ''',
      [id],
    );
  }

  // Get most read tracks
  Future<List<Track>> getMostReadTracks({int limit = 10}) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      orderBy: 'numberOfTimeRead DESC',
      limit: limit,
    );
    return result.map((json) => Track.fromMap(json)).toList();
  }

  // Get next track in sequence
  Future<Track?> getNextTrack(int currentPage) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'page > ?',
      whereArgs: [currentPage],
      orderBy: 'page ASC',
      limit: 1,
    );
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Get previous track in sequence
  Future<Track?> getPreviousTrack(int currentPage) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'page < ?',
      whereArgs: [currentPage],
      orderBy: 'page DESC',
      limit: 1,
    );
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Get tracks with read count above threshold
  Future<List<Track>> getFrequentlyReadTracks({int threshold = 5}) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'numberOfTimeRead >= ?',
      whereArgs: [threshold],
      orderBy: 'numberOfTimeRead DESC',
    );
    return result.map((json) => Track.fromMap(json)).toList();
  }

  // Get all unique kinds/categories
  Future<List<String>> getAllKinds() async {
    final db = await _db;
    final result = await db.rawQuery('''
      SELECT DISTINCT kinds FROM tracks ORDER BY kinds
    ''');
    return result.map((row) => row['kinds'] as String).toList();
  }
}
