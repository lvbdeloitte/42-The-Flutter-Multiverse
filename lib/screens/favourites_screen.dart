import 'package:_42_the_flutter_multiverse/providers/favourites_provider.dart';
import 'package:_42_the_flutter_multiverse/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favourites'),
      ),
      body: favourites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favourite products yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart icon on a product to save it here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final product = favourites[index];

                return Dismissible(
                  key: Key(product.barcode ?? '$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref
                        .read(favouritesProvider.notifier)
                        .toggleFavourite(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${product.productName ?? "Product"} removed from favourites',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
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
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          ref
                              .read(favouritesProvider.notifier)
                              .toggleFavourite(product);
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
