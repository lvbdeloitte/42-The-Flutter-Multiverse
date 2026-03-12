import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

/// State provider to hold the current search query string.
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Future provider to search products by text query.
final searchProductsProvider = FutureProvider<SearchResult?>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return null;

  // TODO: Create a list of Parameter objects containing:
  // - SearchTerms with the query
  // - PageNumber(page: 1)
  // - PageSize(size: 20)
  // - SortBy with SortOption.POPULARITY
  //
  // Then create a ProductSearchQueryConfiguration with:
  // - parametersList: your parameters list
  // - version: ProductQueryVersion.v3
  //
  // Finally call OpenFoodAPIClient.searchProducts(null, config)
  // and return the result.
  throw UnimplementedError('Implement product search');
});
