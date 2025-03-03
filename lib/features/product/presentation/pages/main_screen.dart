import 'package:chairy_e_commerce_app/features/product/presentation/pages/cart_screen.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex; // ✅ لجعل الصفحة تبدأ من أي `index`
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    HomeScreen(),
    ProductPage(),
    CartScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // ✅ بدء الصفحة من `initialIndex`
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavItem(Icons.home_rounded, 0),
          _buildNavItem(Icons.category_rounded, 1),
          _buildNavItem(Icons.shopping_cart_rounded, 2),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Icon(icon, color: mainColor, size: 30),
      ),
      icon: Icon(icon, color: Colors.grey.shade400, size: 30),
      label: '',
    );
  }
}
