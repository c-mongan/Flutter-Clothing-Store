import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/basket_controller.dart';
import '../../widgets/basket_products.dart';
import '../../widgets/basket_total.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

//class CartPage extends StatefulWidget {
class BasketPage extends StatelessWidget {
  BasketPage({Key? key}) : super(key: key);
//Route name
  static const String routeName = '/basket';
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  //Route Method
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => BasketPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomisedAppBar(title: "Basket"),
      bottomNavigationBar: const CustomisedNavigationBar(),
      body: Column(children: [
        if (isProducts(controller) == true) ...[
          const Text("Empty"),
        ] else ...[
          BasketProducts(),
          BasketTotal(),
        ],
      ]),
    );
  }
}
