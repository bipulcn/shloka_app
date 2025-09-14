class Word {
  final int? id;
  final String sanskrit;
  final String bengali;
  final String english;
  final String pronounce;
  final bool viewed;
  final bool learnt;
  final int numberOfTimeRead;

  Word({
    this.id,
    required this.sanskrit,
    required this.bengali,
    required this.english,
    required this.pronounce,
    this.viewed = false,
    this.learnt = false,
    this.numberOfTimeRead = 0,
  });

  // Convert a Word into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sanskrit': sanskrit,
      'bengali': bengali,
      'english': english,
      'pronounce': pronounce,
      'viewed': viewed,
      'learnt': learnt,
      'numberOfTimeRead': numberOfTimeRead,
    };
  }

  // Convert a Map into a Word
  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      sanskrit: map['sanskrit'] ?? '',
      bengali: map['bengali'] ?? '',
      english: map['english'] ?? '',
      pronounce: map['pronounce'] ?? '',
      viewed: map['viewed'] ?? 0,
      learnt: map['learnt'] ?? 0,
      numberOfTimeRead: map['numberOfTimeRead'] ?? 0,
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      sanskrit: json['sanskrit'],
      bengali: json['bengali'],
      english: json['english'],
      pronounce: json['pronounce'],
      viewed: json['viewed'] == 1,
      learnt: json['learnt'] == 1,
      numberOfTimeRead: json['numberOfTimeRead'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sanskrit': sanskrit,
      'bengali': bengali,
      'english': english,
      'pronounce': pronounce,
      'viewed': viewed ? 1 : 0,
      'learnt': learnt ? 1 : 0,
      'numberOfTimeRead': numberOfTimeRead,
    };
  }

  // Create a copy of Word with updated values
  // Word copyWith({
  //   int? id,
  //   String? sanskrit,
  //   String? bengali,
  //   String? english,
  //   String? pronounce,
  //   int? viewed,
  //   int? learnt,
  //   int? numberOfTimeRead,
  // }) {
  //   return Word(
  //     id: id ?? this.id,
  //     sanskrit: sanskrit ?? this.sanskrit,
  //     bengali: bengali ?? this.bengali,
  //     english: english ?? this.english,
  //     pronounce: pronounce ?? this.pronounce,
  //     viewed: viewed ?? this.viewed,
  //     learnt: learnt ?? this.learnt,
  //     numberOfTimeRead: numberOfTimeRead ?? this.numberOfTimeRead,
  //   );
  // }

  // Override toString for easier debugging
  @override
  String toString() {
    return 'Word(id: $id, sanskrit: $sanskrit, bengali: $bengali, english: $english, pronounce: $pronounce, viewed: $viewed, learnt: $learnt, numberOfTimeRead: $numberOfTimeRead)';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Word &&
        other.id == id &&
        other.sanskrit == sanskrit &&
        other.bengali == bengali &&
        other.english == english &&
        other.pronounce == pronounce &&
        other.viewed == viewed &&
        other.learnt == learnt &&
        other.numberOfTimeRead == numberOfTimeRead;
  }

  // Override hashCode
  @override
  int get hashCode {
    return Object.hash(
      id,
      sanskrit,
      bengali,
      english,
      pronounce,
      viewed,
      learnt,
      numberOfTimeRead,
    );
  }
}
