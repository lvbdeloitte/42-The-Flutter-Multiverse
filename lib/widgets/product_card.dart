import 'package:_42_the_flutter_multiverse/providers/favourites_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'detail_row.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              // Product Image
              if (imageUrl != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                      placeholder: (_, _) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (_, _, _) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 48),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Product Name + Like Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product!.productName ?? 'Unknown Product',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      ref.watch(
                            favouritesProvider.select(
                              (favs) => favs.any(
                                (p) => p.barcode == product!.barcode,
                              ),
                            ),
                          )
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          ref.watch(
                            favouritesProvider.select(
                              (favs) => favs.any(
                                (p) => p.barcode == product!.barcode,
                              ),
                            ),
                          )
                          ? Colors.red
                          : null,
                      size: 28,
                    ),
                    onPressed: () {
                      ref
                          .read(favouritesProvider.notifier)
                          .toggleFavourite(product!);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Brand
              if (product!.brands != null)
                Text(
                  product!.brands!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              const Divider(height: 24),

              // Details
              DetailRow(
                icon: Icons.scale,
                label: 'Quantity',
                value: product!.quantity ?? 'N/A',
              ),
              DetailRow(
                icon: Icons.restaurant,
                label: 'Salt (per 100g)',
                value:
                    '${product!.nutriments?.getValue(Nutrient.salt, PerSize.oneHundredGrams) ?? 'N/A'} g',
              ),
              DetailRow(
                icon: Icons.cookie,
                label: 'Sugar (per 100g)',
                value:
                    '${product!.nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 'N/A'} g',
              ),
              DetailRow(
                icon: Icons.water_drop,
                label: 'Saturated Fat (per 100g)',
                value:
                    '${product!.nutriments?.getValue(Nutrient.saturatedFat, PerSize.oneHundredGrams) ?? 'N/A'} g',
              ),
              DetailRow(
                icon: Icons.fitness_center,
                label: 'Protein (per 100g)',
                value:
                    '${product!.nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 'N/A'} g',
              ),
              DetailRow(
                icon: Icons.local_fire_department,
                label: 'Calories (per 100g)',
                value:
                    '${product!.nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 'N/A'} kcal',
              ),

              if (product!.additives?.names != null &&
                  product!.additives!.names.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Additives',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: product!.additives!.names
                      .map(
                        (e) => Chip(
                          label: Text(e, style: const TextStyle(fontSize: 12)),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],

              if (product!.allergens?.names != null &&
                  product!.allergens!.names.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Allergens',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: product!.allergens!.names
                      .map(
                        (e) => Chip(
                          label: Text(e, style: const TextStyle(fontSize: 12)),
                          backgroundColor: Colors.orange[100],
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
