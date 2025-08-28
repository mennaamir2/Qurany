import 'package:flutter/material.dart';
import '../models/azkar_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<AzkarList> _favorites = [];

  List<AzkarList> get favorites => _favorites;

  void addToFavorites(AzkarList item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(AzkarList item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
      notifyListeners();
    }
  }

  bool isFavorite(AzkarList item) {
    return _favorites.contains(item);
  }
}
