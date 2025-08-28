import 'package:azkary/core/models/hadith_model.dart';
import 'package:azkary/core/models/quran_model.dart';
import 'package:flutter/services.dart';
import '../models/azkar_model.dart';

class JsonLoader {
  static Future<Azkar> loadAzkarData() async {
    try {
      String response = await rootBundle.loadString('assets/json/adhkar.json');
      return azkarFromJson(response);
    } catch (e) {
      print("حدث خطأ أثناء تحميل البيانات: $e");
      rethrow;
    }
  }

  static Future<List<Hadith>> loadDoaaData() async {
    try {
      String response =
          await rootBundle.loadString('assets/json/40-hadith-nawawi.json');
      return hadithFromJson(response);
    } catch (e) {
      print("حدث خطأ أثناء تحميل البيانات: $e");
      rethrow;
    }
  }
  static Future<List<Quran>> loadQuranData() async {
    try {
      String response = await rootBundle.loadString('assets/json/allQuran.json');
      return quranFromJson(response);
    } catch (e) {
      print("حدث خطأ أثناء تحميل البيانات: $e");
      rethrow;
    }
  }
}
