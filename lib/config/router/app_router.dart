import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/checkout_screen.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/product_details_screen.dart';
import '../../features/product/presentation/pages/cart_screen.dart';
import '../../features/product/presentation/pages/home_screen.dart';
import '../../features/product/presentation/pages/main_screen.dart';
import '../../features/product/presentation/pages/search_screen.dart';
import '../../features/product/presentation/pages/settings_menu_screen.dart';
import '../../features/product/presentation/pages/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String main = '/main';
  static const String productPage = '/product-page';
  static const String cartPage = '/cart-page';
  static const String productDetails = '/product-details';
  static const String settingsMenu = '/settings-menu';
  static const String search = '/search';
  static const String checkout = '/checkout';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (_) => const MainScreen(initialIndex: 0));

      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case AppRoutes.checkout:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());

      case AppRoutes.productPage:
        return MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 1));

      case AppRoutes.cartPage:
        return MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2));

      case AppRoutes.productDetails:
        final CartItem cartItem = settings.arguments as CartItem;
        // ✅ Convert `CartItem` to `ProductEntity` before passing it
        ProductEntity productEntity = ProductEntity(
          id: cartItem.id,
          title: cartItem.title,
          description: "", // Add proper description
          price: cartItem.price,
          discount: "0", // Adjust discount if needed
          discountPrice: cartItem.price, // Modify if needed
          quantity: cartItem.quantity,
        );
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                  product: productEntity,
                ));

      case AppRoutes.settingsMenu:
        return MaterialPageRoute(builder: (_) => const SettingsMenuScreen());

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page Not Found')),
          ),
        );
    }
  }
}
