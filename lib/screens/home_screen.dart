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
    // TODO: Update the barcodeProvider state with the text from _controller
    // Hint: Use ref.read(barcodeProvider.notifier).state = ...
    // Only update if _controller.text is not empty
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
              // TODO: Use a switch expression to handle the AsyncValue states:
              // - AsyncData: If product exists, show product info using Text() widgets
              //   Display: productName, brands, barcode, quantity, and nutrients
              // - AsyncError: Show error message
              // - Default (_): Show CircularProgressIndicator
              child: const Center(
                child: Text('Enter a barcode to search for a product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
