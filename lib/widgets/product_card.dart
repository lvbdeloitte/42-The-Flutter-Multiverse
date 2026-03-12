import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'detail_row.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(child: Text('Product not found'));
    }

    final imageUrl = product!.imageFrontUrl ?? product!.imageFrontSmallUrl;

    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Display the product image using CachedNetworkImage
              // - Use ClipRRect with borderRadius: 12 to round corners
              // - If imageUrl is null, skip this section
              // - Use placeholder and errorWidget callbacks
              const SizedBox(height: 16),

              // TODO: Display the product name using Text widget
              // Use Theme.of(context).textTheme.headlineSmall with bold fontWeight
              const Placeholder(fallbackHeight: 30),
              const SizedBox(height: 4),

              // TODO: Display the brand if product!.brands is not null
              // Use Theme.of(context).textTheme.titleMedium with primary color
              const Divider(height: 24),

              // TODO: Display product quantity using DetailRow widget
              // DetailRow(icon: Icons.scale, label: 'Quantity', value: ...)
              const Placeholder(fallbackHeight: 24),

              // TODO: Loop through Nutrient.values and display each non-zero nutrient
              // Filter with: val != null && val > 0
              // Use product!.nutriments!.getValue(nutrient, PerSize.oneHundredGrams)
              // Display each as a DetailRow

              // TODO: Display additives as Chips if product!.additives?.names is not empty
              // Use Wrap widget with spacing: 6, runSpacing: 6

              // TODO: Display allergens as Chips if product!.allergens?.names is not empty
              // Use orange background color for allergen chips
            ],
          ),
        ),
      ),
    );
  }
}
