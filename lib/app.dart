import 'package:_42_the_flutter_multiverse/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FoodScannerApp extends StatelessWidget {
  const FoodScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Food Scanner'),
    );
  }
}
