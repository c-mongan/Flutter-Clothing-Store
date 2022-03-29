import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:health_app_fyp/model/product.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';

  final Product product;

  ProductPage({Key? key, required this.product}) : super(key: key);

  static Route route(product) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductPage(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomisedAppBar(title: "Screen"),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: Row(children: [
          Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            product.price.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ]));
  }
}
