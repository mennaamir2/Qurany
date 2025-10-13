import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/azkar_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<AzkarList> _favorites = [];

  List<AzkarList> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavorites(); // 📝 تحميل المفضلة أول ما البروڤايدر يشتغل
  }

  Future<void> addToFavorites(AzkarList item) async {
    if (!_favorites.any((fav) => fav.zekr == item.zekr && fav.title == item.title )) {
      _favorites.add(item);
      await _saveFavorites(); // 📝 حفظ المفضلة بعد الإضافة
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(AzkarList item) async {
    _favorites.removeWhere((fav) => fav.zekr == item.zekr && fav.title == item.title);
    await _saveFavorites(); // 📝 حفظ المفضلة بعد الحذف
    notifyListeners();
  }

  bool isFavorite(AzkarList item) {
    return _favorites.any((fav) => fav.zekr == item.zekr && fav.title == item.title);
  }

  /// 📝 حفظ المفضلة في SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _favorites.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('favorites', jsonList);
  }

  /// 📝 تحميل المفضلة من SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('favorites') ?? [];

    _favorites.clear();
    _favorites.addAll(jsonList
        .map((item) => AzkarList.fromJson(jsonDecode(item)))
        .toList());

    notifyListeners();
  }
}
