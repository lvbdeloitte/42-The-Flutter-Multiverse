import 'package:_42_the_flutter_multiverse/providers/barcode_provider.dart';
import 'package:_42_the_flutter_multiverse/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchByBarcode() {
    if (_controller.text.isNotEmpty) {
      ref.read(barcodeProvider.notifier).state = _controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodDetails = ref.watch(getFoodDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter barcode',
                hintText: 'e.g., 3017624010701',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchByBarcode,
                ),
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _searchByBarcode(),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: switch (foodDetails) {
                AsyncData(:final value) => value?.product != null
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product: ${value!.product!.productName ?? "N/A"}',
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
                      )
                    : const Center(
                        child: Text('Enter a barcode to search for a product'),
                      ),
                AsyncError(:final error) => Center(
                    child: Text('Error: $error'),
                  ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
