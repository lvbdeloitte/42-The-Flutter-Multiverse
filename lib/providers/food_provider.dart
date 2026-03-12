import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'barcode_provider.dart';

// TODO: Create a FutureProvider<ProductResultV3?> named `getFoodDetailsProvider`
// 1. Watch the barcodeProvider to get the current barcode string
// 2. If barcode is empty, return null
// 3. Create a ProductQueryConfiguration with the barcode and version: ProductQueryVersion.v3
// 4. Call OpenFoodAPIClient.getProductV3(config) and return the result
final getFoodDetailsProvider = FutureProvider<ProductResultV3?>((ref) async {
  final barcode = ref.watch(barcodeProvider);
  if (barcode.isEmpty) return null;

  ProductQueryConfiguration config = ProductQueryConfiguration(
    '',
    version: ProductQueryVersion.v3,
  );
  ProductResultV3 product = await OpenFoodAPIClient.getProductV3(config);
  return product;
});
