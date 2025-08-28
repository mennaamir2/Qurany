// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Azkar azkarFromJson(String str) => Azkar.fromJson(json.decode(str));

String azkarToJson(Azkar data) => json.encode(data.toJson());

class Azkar {
  List<AllAzkar> allAzkar;

  Azkar({
    required this.allAzkar,
  });

  factory Azkar.fromJson(Map<String, dynamic> json) => Azkar(
    allAzkar: List<AllAzkar>.from(json["allAzkar"].map((x) => AllAzkar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allAzkar": List<dynamic>.from(allAzkar.map((x) => x.toJson())),
  };
}

class AllAzkar {
  String title;
  String zikrCategory;
  String content;
  List<AzkarList> azkarList;

  AllAzkar({
    required this.title,
    required this.zikrCategory,
    required this.content,
    required this.azkarList,
  });

  factory AllAzkar.fromJson(Map<String, dynamic> json) => AllAzkar(
    title: json["title"],
    zikrCategory: json["zikrCategory"],
    content: json["content"],
    azkarList: List<AzkarList>.from(json["azkarList"].map((x) => AzkarList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "zikrCategory": zikrCategory,
    "content": content,
    "azkarList": List<dynamic>.from(azkarList.map((x) => x.toJson())),
  };
}

class AzkarList {
  String title;
  String? count;
  String? description;
  String? reference;
  String? zekr;
  bool? haveList;
  List<ListElement>? list;

  AzkarList({
    required this.title,
    this.count,
    this.description,
    this.reference,
    this.zekr,
    this.haveList,
    this.list,
  });

  factory AzkarList.fromJson(Map<String, dynamic> json) => AzkarList(
    title: json["title"],
    count: json["count"],
    description: json["description"],
    reference: json["reference"],
    zekr: json["zekr"],
    haveList: json["haveList"],
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "count": count,
    "description": description,
    "reference": reference,
    "zekr": zekr,
    "haveList": haveList,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  String title;
  String count;
  String description;
  String reference;
  String zekr;

  ListElement({
    required this.title,
    required this.count,
    required this.description,
    required this.reference,
    required this.zekr,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    title: json["title"],
    count: json["count"],
    description: json["description"],
    reference: json["reference"],
    zekr: json["zekr"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "count": count,
    "description": description,
    "reference": reference,
    "zekr": zekr,
  };
}
