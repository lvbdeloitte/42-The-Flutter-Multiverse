import 'package:_42_the_flutter_multiverse/providers/food_provider.dart';
import 'package:_42_the_flutter_multiverse/providers/history_provider.dart';
import 'package:_42_the_flutter_multiverse/widgets/empty_state.dart';
import 'package:_42_the_flutter_multiverse/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodResult extends ConsumerWidget {
  const FoodResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodDetails = ref.watch(getFoodDetailsProvider);

    return switch (foodDetails) {
      AsyncData(:final value) =>
        value == null
            ? const EmptyState()
            : Builder(
                builder: (context) {
                  // TODO: Add product to history when successfully loaded
                  // Use WidgetsBinding.instance.addPostFrameCallback to avoid
                  // calling setState during build. Inside the callback:
                  // ref.read(historyProvider.notifier).addProduct(value.product!)
                  return ProductCard(product: value.product);
                },
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
