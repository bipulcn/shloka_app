class Track {
  final int? id;
  final String kinds;
  final int page;
  final int prev;
  final int next;
  final int numberOfTimeRead;

  Track({
    this.id,
    required this.kinds,
    required this.page,
    required this.prev,
    required this.next,
    this.numberOfTimeRead = 0,
  });

  // Convert a Track into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kinds': kinds,
      'page': page,
      'prev': prev,
      'next': next,
      'numberOfTimeRead': numberOfTimeRead,
    };
  }

  // Convert a Map into a Track
  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'],
      kinds: map['kinds'] ?? '',
      page: map['page'] ?? 0,
      prev: map['prev'] ?? 0,
      next: map['next'] ?? 0,
      numberOfTimeRead: map['numberOfTimeRead'] ?? 0,
    );
  }

  // Create a copy of Track with updated values
  Track copyWith({
    int? id,
    String? kinds,
    int? page,
    int? prev,
    int? next,
    int? numberOfTimeRead,
  }) {
    return Track(
      id: id ?? this.id,
      kinds: kinds ?? this.kinds,
      page: page ?? this.page,
      prev: prev ?? this.prev,
      next: next ?? this.next,
      numberOfTimeRead: numberOfTimeRead ?? this.numberOfTimeRead,
    );
  }

  // Override toString for easier debugging
  @override
  String toString() {
    return 'Track(id: $id, kinds: $kinds, page: $page, prev: $prev, next: $next, numberOfTimeRead: $numberOfTimeRead)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Track &&
        other.id == id &&
        other.kinds == kinds &&
        other.page == page &&
        other.prev == prev &&
        other.next == next &&
        other.numberOfTimeRead == numberOfTimeRead;
  }

  // Override hashCode
  @override
  int get hashCode {
    return Object.hash(id, kinds, page, prev, next, numberOfTimeRead);
  }
}
