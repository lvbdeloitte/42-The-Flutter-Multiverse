import 'package:_42_the_flutter_multiverse/providers/food_provider.dart';
import 'package:_42_the_flutter_multiverse/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodResult extends ConsumerWidget {
  const FoodResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodDetails = ref.watch(getFoodDetailsProvider);

    return switch (foodDetails) {
      AsyncData(:final value) =>
        value == null
            ? const EmptyState()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product: ${value.product!.productName ?? "N/A"}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Brand: ${value.product!.brands ?? "N/A"}'),
                  Text('Barcode: ${value.product!.barcode ?? "N/A"}'),
                  Text('Quantity: ${value.product!.quantity ?? "N/A"}'),
                  if (value.product!.nutriments != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Nutrition (per 100g):',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Energy: ${value.product!.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? "N/A"} kcal',
                    ),
                    Text(
                      'Fat: ${value.product!.nutriments!.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? "N/A"} g',
                    ),
                    Text(
                      'Carbs: ${value.product!.nutriments!.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? "N/A"} g',
                    ),
                    Text(
                      'Proteins: ${value.product!.nutriments!.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? "N/A"} g',
                    ),
                    Text(
                      'Salt: ${value.product!.nutriments!.getValue(Nutrient.salt, PerSize.oneHundredGrams) ?? "N/A"} g',
                    ),
                  ],
                ],
              ),
      AsyncError(:final error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error: $error', textAlign: TextAlign.center),
          ],
        ),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
