class ShlokaModel {
  final int? id;
  final String name;
  final String kinds;
  final int chapter;
  final int serial;
  final String sanskrit;
  final String bengali;
  final String english;
  final String eng_mean;
  final String bng_mean;
  final String wordMeaning;
  final bool viewed;
  final bool learnt;
  final bool difficultyLevel;
  final DateTime? lastReadDate;
  final int numberOfTimeRead;
  final DateTime? firstReadDate;

  ShlokaModel({
    this.id,
    required this.name,
    required this.kinds,
    this.chapter = 0,
    this.serial = 0,
    required this.sanskrit,
    required this.bengali,
    required this.english,
    required this.eng_mean,
    required this.bng_mean,
    required this.wordMeaning,
    this.viewed = false,
    this.learnt = false,
    this.difficultyLevel = false,
    this.lastReadDate,
    this.numberOfTimeRead = 0,
    this.firstReadDate,
  });

  factory ShlokaModel.fromJson(Map<String, dynamic> json) {
    return ShlokaModel(
      id: json['id'],
      name: json['name'],
      kinds: json['kinds'],
      chapter: json['chapter'],
      serial: json['serial'],
      sanskrit: json['sanskrit'],
      bengali: json['bengali'],
      english: json['english'],
      eng_mean: json['eng_mean'],
      bng_mean: json['bng_mean'],
      wordMeaning: json['wordMeaning'],
      viewed: json['viewed'] == 1,
      learnt: json['learnt'] == 1,
      difficultyLevel: json['difficultyLevel'] == 1,
      lastReadDate: json['lastReadDate'] != null
          ? DateTime.tryParse(json['lastReadDate'])
          : null,
      numberOfTimeRead: json['numberOfTimeRead'] ?? 0,
      firstReadDate: json['firstReadDate'] != null
          ? DateTime.tryParse(json['firstReadDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'kinds': kinds,
      'chapter': chapter,
      'serial': serial,
      'sanskrit': sanskrit,
      'bengali': bengali,
      'english': english,
      'eng_mean': eng_mean,
      'bng_mean': bng_mean,
      'wordMeaning': wordMeaning,
      'viewed': viewed ? 1 : 0,
      'learnt': learnt ? 1 : 0,
      'difficultyLevel': difficultyLevel ? 1 : 0,
      'lastReadDate': lastReadDate?.toIso8601String(),
      'numberOfTimeRead': numberOfTimeRead,
      'firstReadDate': firstReadDate?.toIso8601String(),
    };
  }
}
