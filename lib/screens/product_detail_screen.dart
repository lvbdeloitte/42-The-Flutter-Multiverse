import 'package:_42_the_flutter_multiverse/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(product.productName ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductCard(product: product),
      ),
    );
  }
}
