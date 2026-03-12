import 'package:_42_the_flutter_multiverse/providers/barcode_provider.dart';
import 'package:_42_the_flutter_multiverse/providers/search_provider.dart';
import 'package:_42_the_flutter_multiverse/screens/barcode_scanner_screen.dart';
import 'package:_42_the_flutter_multiverse/widgets/food_result.dart';
import 'package:_42_the_flutter_multiverse/widgets/search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = TextEditingController();
  // TODO: Add a bool _showingProduct = false to track whether
  // we're showing the single product view or the search results list

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // TODO: Implement _searchByName() method that:
  // - Checks if _controller.text is not empty
  // - Sets _showingProduct to false (we're showing search results)
  // - Updates searchQueryProvider with the search text

  // TODO: Implement _selectProduct(String barcode) method that:
  // - Sets _showingProduct to true (we're showing a single product)
  // - Updates barcodeProvider with the selected barcode

  void _resetProduct() {
    _controller.clear();
    // TODO: Also reset _showingProduct to false
    ref.read(barcodeProvider.notifier).state = '';
    // TODO: Also reset searchQueryProvider to empty string
  }

  Future<void> _scanBarcode() async {
    final String? barcode = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (barcode != null && barcode.isNotEmpty) {
      _controller.clear();
      // TODO: Set _showingProduct to true
      // TODO: Reset searchQueryProvider to empty string
      ref.read(barcodeProvider.notifier).state = barcode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // TODO: Add a conditional "back" button that shows when _showingProduct is true
          // When pressed, set _showingProduct to false to return to search results
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetProduct,
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Search product',
                      hintText: 'e.g., Coca-Cola, Nutella...',
                      prefixIcon: const Icon(Icons.search),
                      // TODO: Add suffixIcon with an IconButton that calls _searchByName
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    // TODO: Update onSubmitted to call _searchByName
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: _scanBarcode,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.camera_alt, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // TODO: Replace with conditional rendering:
            // - If _showingProduct: show FoodResult()
            // - Otherwise: show SearchResults(onProductSelected: _selectProduct)
            const Expanded(child: FoodResult()),
          ],
        ),
      ),
    );
  }
}
