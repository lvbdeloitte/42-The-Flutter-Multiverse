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
  bool _showingProduct = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchByName() {
    if (_controller.text.isNotEmpty) {
      setState(() => _showingProduct = false);
      ref.read(searchQueryProvider.notifier).state = _controller.text;
    }
  }

  void _selectProduct(String barcode) {
    setState(() => _showingProduct = true);
    ref.read(barcodeProvider.notifier).state = barcode;
  }

  void _resetProduct() {
    _controller.clear();
    setState(() => _showingProduct = false);
    ref.read(barcodeProvider.notifier).state = '';
    ref.read(searchQueryProvider.notifier).state = '';
  }

  Future<void> _scanBarcode() async {
    final String? barcode = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (barcode != null && barcode.isNotEmpty) {
      _controller.clear();
      setState(() => _showingProduct = true);
      ref.read(searchQueryProvider.notifier).state = '';
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
          if (_showingProduct)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() => _showingProduct = false);
              },
              tooltip: 'Back to results',
            ),
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
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _searchByName,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _searchByName(),
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
            Expanded(
              child: _showingProduct
                  ? const FoodResult()
                  : SearchResults(onProductSelected: _selectProduct),
            ),
          ],
        ),
      ),
    );
  }
}
