import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomisedAppBar(title: "Screen"),
      bottomNavigationBar: const CustomisedNavigationBar(),
    );
  }
}
