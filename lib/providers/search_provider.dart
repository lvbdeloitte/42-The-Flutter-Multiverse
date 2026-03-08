import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider = FutureProvider<SearchResult?>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return null;

  final parameters = <Parameter>[
    SearchTerms(terms: [query]),
    const PageNumber(page: 1),
    const PageSize(size: 20),
    const SortBy(option: SortOption.POPULARITY),
  ];

  final config = ProductSearchQueryConfiguration(
    parametersList: parameters,
    version: ProductQueryVersion.v3,
  );

  final result = await OpenFoodAPIClient.searchProducts(null, config);

  return result;
});
