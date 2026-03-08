import 'package:_42_the_flutter_multiverse/screens/favourites_screen.dart';
import 'package:_42_the_flutter_multiverse/screens/history_screen.dart';
import 'package:_42_the_flutter_multiverse/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FoodScannerApp extends StatefulWidget {
  const FoodScannerApp({super.key});

  @override
  State<FoodScannerApp> createState() => _FoodScannerAppState();
}

class _FoodScannerAppState extends State<FoodScannerApp> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  static const List<Widget> _pages = [
    HomeScreen(title: 'Food Scanner'),
    FavouritesScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: List.generate(_pages.length, (index) {
            return Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (settings) {
                return MaterialPageRoute(builder: (context) => _pages[index]);
              },
            );
          }),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            if (index == _selectedIndex) {
              // Pop to root if tapping the already selected tab
              _navigatorKeys[index].currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.qr_code_scanner),
              selectedIcon: Icon(Icons.qr_code_scanner),
              label: 'Scanner',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              selectedIcon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
