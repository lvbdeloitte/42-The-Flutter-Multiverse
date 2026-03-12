import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favouritesKey = 'favourites';

class FavouritesNotifier extends StateNotifier<List<Product>> {
  FavouritesNotifier() : super([]) {
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favouritesKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      state = jsonList
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((p) => p.toJson()).toList());
    await prefs.setString(_favouritesKey, jsonString);
  }

  void toggleFavourite(Product product) {
    final exists = state.any((p) => p.barcode == product.barcode);
    if (exists) {
      state = state.where((p) => p.barcode != product.barcode).toList();
    } else {
      state = [product, ...state];
    }
  }

  bool isFavourite(String? barcode) {
    if (barcode == null) return false;
    return state.any((p) => p.barcode == barcode);
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouritesNotifier, List<Product>>(
      (ref) => FavouritesNotifier(),
    );
