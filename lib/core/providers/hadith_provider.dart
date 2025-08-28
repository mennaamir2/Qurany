import 'package:azkary/core/models/hadith_model.dart';
import 'package:flutter/material.dart';
import '../utils/json_loder.dart';
class HadithProvider with ChangeNotifier {
  List <Hadith>? hadith;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchDoaa() async {
    _isLoading = true;
    notifyListeners();

    try {
      hadith = await JsonLoader.loadDoaaData();
      print("Data loaded successfully: ${hadith?.length} items");
    } catch (e) {
      print("خطأ أثناء جلب الأذكار: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}