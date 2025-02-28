import 'package:flutter/material.dart';
import 'package:petmate/models/product_model.dart';

class FavsProvider with ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  bool isFavorite(ProductModel product) {
    return _favorites.contains(product);
  }

  void toggleFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
