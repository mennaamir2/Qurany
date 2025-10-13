import 'package:azkary/core/models/quran_model.dart';
import 'package:flutter/material.dart';
import '../utils/json_loader.dart';


class QuranProvider with ChangeNotifier {
  List <Quran>? quran;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchQuran() async {
    _isLoading = true;
    notifyListeners();

    try {
      quran = await JsonLoader.loadQuranData();
      print("Data loaded successfully: ${quran?.length} items");
    } catch (e) {
      print("خطأ أثناء جلب الأذكار: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}