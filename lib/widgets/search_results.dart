import 'package:_42_the_flutter_multiverse/providers/search_provider.dart';
import 'package:_42_the_flutter_multiverse/widgets/empty_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget that displays search results from the OpenFoodFacts API.
class SearchResults extends ConsumerWidget {
  const SearchResults({super.key, required this.onProductSelected});

  final void Function(String barcode) onProductSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchProductsProvider);

    // TODO: Use a switch expression on searchResults to handle:
    //
    // 1. AsyncData case:
    //    - If value is null, return EmptyState()
    //    - If value.products is null or empty, show "No products found" text
    //    - Otherwise, build a ListView.builder with:
    //      - itemCount: value.products!.length
    //      - Each item should be a Card containing a ListTile with:
    //        - leading: CachedNetworkImage (50x50) using product.imageFrontSmallUrl
    //          or fallback Icon(Icons.shopping_bag) if no image
    //        - title: product.productName (bold, max 2 lines)
    //        - subtitle: product.brands (if available)
    //        - trailing: Icon(Icons.chevron_right)
    //        - onTap: call onProductSelected(product.barcode!)
    //
    // 2. AsyncError case:
    //    - Display an error icon and the error message
    //
    // 3. Default case (loading):
    //    - Return CircularProgressIndicator centered
    //
    return const Center(child: Text('TODO: Implement search results'));
  }
}
