class Track {
  final int? id;
  final String kinds;
  final String main;
  final int subs;

  Track({this.id, required this.kinds, required this.main, required this.subs});

  // Convert a Track into a Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'kinds': kinds, 'main': main, 'subs': subs};
  }

  Map<String, dynamic> toValue() {
    return {'kinds': kinds, 'main': main, 'subs': subs};
  }

  // Convert a Map into a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'],
      kinds: map['kinds'] ?? '',
      main: map['main'] ?? 0,
      subs: map['subs'] ?? 0,
    );
  }

  // Create a copy of Track with updated values
  Track copyWith({
    int? id,
    String? kinds,
    String? main,
    int? subs,
    int? prev,
    int? next,
    int? numberOfTimeRead,
  }) {
    return Track(
      id: id ?? this.id,
      kinds: kinds ?? this.kinds,
      main: main ?? this.main,
      subs: subs ?? this.subs,
    );
  }

  // Override toString for easier debugging
  @override
  String toString() {
    return 'Track(id: $id, kinds: $kinds, main: $main, subs: $subs)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Track &&
        other.id == id &&
        other.kinds == kinds &&
        other.main == main &&
        other.subs == subs;
  }

  // Override hashCode
  @override
  int get hashCode {
    return Object.hash(id, kinds, main, subs);
  }
}
