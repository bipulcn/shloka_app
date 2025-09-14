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
    final result = await db.query('tracks', orderBy: 'main ASC');
    return result.map((json) => Track.fromMap(json)).toList();
  }

  Future<Track?> getPage() async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'kinds=?',
      whereArgs: ['page'],
    );
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Read a single track by id
  Future<Track?> readTrack(int id) async {
    final db = await _db;
    final result = await db.query('tracks', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Read tracks by kind/category
  Future<List<Track>> rdByKind(String kind) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'kinds = ?',
      whereArgs: [kind],
      orderBy: 'main ASC',
    );
    return result.map((json) => Track.fromMap(json)).toList();
  }

  // Read track by main number
  Future<Track?> rdByMain(int main) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'main = ?',
      whereArgs: [main],
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

  Future<bool> getTheme() async {
    List<Track> th = await rdByKind('theme');
    if (th.isNotEmpty) {
      return th.first.main == "dark" ? true : false;
    }
    return false;
  }

  Future<int> getPre(String knd) async {
    List<Track> tk = await rdByKind(knd);
    return tk.isNotEmpty ? tk.first.subs : 0;
  }

  // Update a track
  Future<int> uKindTrack(Track track) async {
    final db = await _db;
    var ck = await db.query(
      'tracks',
      where: 'kinds=?',
      whereArgs: [track.kinds],
    );
    if (ck.isNotEmpty) {
      Map<String, Object?> fs = ck.first;
      return await db.update(
        'tracks',
        track.toValue(),
        where: 'id = ?',
        whereArgs: [fs['id']],
      );
    } else {
      return createTrack(track);
    }
  }

  // Delete a track
  Future<int> deleteTrack(int id) async {
    final db = await _db;
    return await db.delete('tracks', where: 'id = ?', whereArgs: [id]);
  }

  // Get next track in sequence
  Future<Track?> getNextTrack(int currentMain) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'main > ?',
      whereArgs: [currentMain],
      orderBy: 'main ASC',
      limit: 1,
    );
    return result.isNotEmpty ? Track.fromMap(result.first) : null;
  }

  // Get previous track in sequence
  Future<Track?> getPreviousTrack(int currentMain) async {
    final db = await _db;
    final result = await db.query(
      'tracks',
      where: 'main < ?',
      whereArgs: [currentMain],
      orderBy: 'main DESC',
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
