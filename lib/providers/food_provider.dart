import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'barcode_provider.dart';

final getFoodDetailsProvider = FutureProvider<ProductResultV3?>((ref) async {
  final barcode = ref.watch(barcodeProvider);
  if (barcode.isEmpty) return null;

  ProductQueryConfiguration config = ProductQueryConfiguration(
    barcode,
    version: ProductQueryVersion.v3,
  );
  ProductResultV3 product = await OpenFoodAPIClient.getProductV3(config);
  return product;
});
