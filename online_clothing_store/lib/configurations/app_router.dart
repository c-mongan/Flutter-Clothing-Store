import 'package:flutter/material.dart';

import '../screens/screens.dart';

class ApplicationRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomePage.route();
      case LoadingPage.routeName:
        return LoadingPage.route();
      case BasketPage.routeName:
        return BasketPage.route();
         case CheckoutPage.routeName:
        return CheckoutPage.route();
         case InventoryPage.routeName:
        return InventoryPage.route();
      case WishlistPage.routeName:
        return WishlistPage.route();
      case ProductPage.routeName:
        return ProductPage.route();
    
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
