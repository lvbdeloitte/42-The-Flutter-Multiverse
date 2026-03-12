import 'package:_42_the_flutter_multiverse/providers/barcode_provider.dart';
import 'package:_42_the_flutter_multiverse/screens/barcode_scanner_screen.dart';
import 'package:_42_the_flutter_multiverse/widgets/food_result.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchByBarcode() {
    if (_controller.text.isNotEmpty) {
      ref.read(barcodeProvider.notifier).state = _controller.text;
    }
  }

  void _resetProduct() {
    _controller.clear();
    ref.read(barcodeProvider.notifier).state = '';
  }

  Future<void> _scanBarcode() async {
    // TODO: Navigate to BarcodeScannerScreen and get the scanned barcode
    // 1. Use Navigator.of(context).push<String>(...) to push BarcodeScannerScreen
    // 2. The scanner returns the barcode as a String? when it pops
    // 3. If barcode is not null and not empty:
    //    - Set _controller.text = barcode
    //    - Update barcodeProvider.notifier.state with the barcode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
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
                      labelText: 'Enter barcode',
                      hintText: 'e.g., 3017624010701',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _searchByBarcode,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _searchByBarcode(),
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
            const Expanded(child: FoodResult()),
          ],
        ),
      ),
    );
  }
}
