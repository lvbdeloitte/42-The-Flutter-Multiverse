import 'package:_42_the_flutter_multiverse/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'Food Scanner',
    version: '1.0.0',
    comment: 'demo app for 42 The Flutter Multiverse',
    system: "Flutter",
    url: 'localhost',
  );

  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.ENGLISH,
  ];

  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.FRANCE;

  runApp(const ProviderScope(child: FoodScannerApp()));
}
