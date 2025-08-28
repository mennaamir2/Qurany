import 'dart:convert';

List<Quran> quranFromJson(String str) => List<Quran>.from(json.decode(str).map((x) => Quran.fromJson(x)));

String quranToJson(List<Quran> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quran {
  int number;
  String name;
  int numberOfAyahs;
  List<Ayah> ayahs;

  Quran({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory Quran.fromJson(Map<String, dynamic> json) => Quran(
    number: json["number"],
    name: json["name"],
    numberOfAyahs: json["numberOfAyahs"],
    ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "numberOfAyahs": numberOfAyahs,
    "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
  };
}

class Ayah {
  int numberInQuran;
  int numberInSurah;
  String audio;
  String text;
  int juz;
  int page;
  dynamic sajda;

  Ayah({
    required this.numberInQuran,
    required this.numberInSurah,
    required this.audio,
    required this.text,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
    numberInQuran: json["numberInQuran"],
    numberInSurah: json["numberInSurah"],
    audio: json["audio"],
    text: json["text"],
    juz: json["juz"],
    page: json["page"],
    sajda: json["sajda"],
  );

  Map<String, dynamic> toJson() => {
    "numberInQuran": numberInQuran,
    "numberInSurah": numberInSurah,
    "audio": audio,
    "text": text,
    "juz": juz,
    "page": page,
    "sajda": sajda,
  };
}

class SajdaClass {
  int id;
  bool recommended;
  bool obligatory;

  SajdaClass({
    required this.id,
    required this.recommended,
    required this.obligatory,
  });

  factory SajdaClass.fromJson(Map<String, dynamic> json) => SajdaClass(
    id: json["id"],
    recommended: json["recommended"],
    obligatory: json["obligatory"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recommended": recommended,
    "obligatory": obligatory,
  };
}
