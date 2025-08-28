import 'dart:convert';

List<Hadith> hadithFromJson(String str) => List<Hadith>.from(json.decode(str).map((x) => Hadith.fromJson(x)));

String hadithToJson(List<Hadith> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hadith {
  String description;
  String hadith;

  Hadith({
    required this.description,
    required this.hadith,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
    description: json["description"],
    hadith: json["hadith"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "hadith": hadith,
  };
}
