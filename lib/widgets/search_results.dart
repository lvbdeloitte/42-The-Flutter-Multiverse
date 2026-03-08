import 'package:_42_the_flutter_multiverse/providers/search_provider.dart';
import 'package:_42_the_flutter_multiverse/widgets/empty_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key, required this.onProductSelected});

  final void Function(String barcode) onProductSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchProductsProvider);

    return switch (searchResults) {
      AsyncData(:final value) =>
        value == null
            ? const EmptyState()
            : (value.products == null || value.products!.isEmpty)
            ? const Center(child: Text('No products found'))
            : ListView.builder(
                itemCount: value.products!.length,
                itemBuilder: (context, index) {
                  final product = value.products![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: product.imageFrontSmallUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: product.imageFrontSmallUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorWidget: (_, _, _) => const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              ),
                            )
                          : const Icon(Icons.shopping_bag, size: 50),
                      title: Text(
                        product.productName ?? 'Unknown Product',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: product.brands != null
                          ? Text(
                              product.brands!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        if (product.barcode != null) {
                          onProductSelected(product.barcode!);
                        }
                      },
                    ),
                  );
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
