import 'package:flutter/material.dart';
import '../models/azkar_model.dart';
import '../utils/json_loader.dart';


class AzkarProvider with ChangeNotifier {
  Azkar? azkar;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchAzkar() async {
    _isLoading = true;
    notifyListeners();

    try {
      azkar = await JsonLoader.loadAzkarData();
      print("Data loaded successfully: ${azkar?.allAzkar.length} categories");
    } catch (e) {
      print("خطأ أثناء جلب الأذكار: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}