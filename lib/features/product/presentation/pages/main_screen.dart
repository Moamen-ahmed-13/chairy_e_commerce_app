import 'package:chairy_e_commerce_app/features/product/presentation/pages/cart_screen.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Widget _currentPage = HomeScreen();

  final List<Widget> _pages = [
    HomeScreen(),
    ProductPage(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.home_rounded,
                  color: mainColor,
                  size: 30,
                ),
              ),
              icon: Icon(
                Icons.home_rounded,
                color: Colors.grey.shade400,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.category_rounded,
                  color: mainColor,
                  size: 30,
                ),
              ),
              icon: Icon(
                Icons.category_rounded,
                color: Colors.grey.shade400,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: mainColor,
                  size: 30,
                ),
              ),
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: Colors.grey.shade400,
                size: 30,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          showUnselectedLabels: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ));
  }
}
