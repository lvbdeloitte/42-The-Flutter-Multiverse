import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _historyKey = 'scan_history';

class HistoryItem {
  final Product product;
  final DateTime scannedAt;

  HistoryItem({required this.product, required this.scannedAt});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'scannedAt': scannedAt.toIso8601String(),
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    product: Product.fromJson(json['product'] as Map<String, dynamic>),
    scannedAt: DateTime.parse(json['scannedAt'] as String),
  );
}

class HistoryNotifier extends StateNotifier<List<HistoryItem>> {
  HistoryNotifier() : super([]) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      state = jsonList
          .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, jsonString);
  }

  void addProduct(Product product) {
    // TODO: Add product to history
    // 1. Check if product already exists using state.any((item) => item.product.barcode == product.barcode)
    // 2. If NOT exists:
    //    - Create new HistoryItem with product and DateTime.now()
    //    - Add to beginning of state: state = [newItem, ...state]
    //    - Call _saveHistory() to persist
  }

  void removeProduct(String barcode) {
    state = state.where((item) => item.product.barcode != barcode).toList();
    _saveHistory();
  }

  void clearHistory() {
    state = [];
    _saveHistory();
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<HistoryItem>>(
      (ref) => HistoryNotifier(),
    );
