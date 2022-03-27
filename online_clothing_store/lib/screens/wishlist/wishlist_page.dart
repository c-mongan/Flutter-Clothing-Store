import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class WishlistPage extends StatelessWidget {
  static const String routeName = '/wish';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => WishlistPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomisedAppBar(title: "Wishlist"),
      bottomNavigationBar: CustomisedNavigationBar(),
    );
  }
}
