import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/basket_products.dart';
import '../../widgets/basket_total.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class BasketPage extends StatelessWidget {
  BasketPage({Key? key, index}) : super(key: key);
  static const String routeName = '/basket';
  final cartController = Get.put(BasketController());
  final productController = Get.put(ProductController());
  final BasketController controller = Get.find();
  late int index = index;

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomisedAppBar(title: "Basket"),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            if (isProducts(controller) == true) ...[
              const SizedBox(height: 200),
              SizedBox(
                height: 20,
                width: 40,
              ),
              const Text(
                "             Your basket is empty",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 70,
                width: 300,
              ),
              GradientIconButtonFb7(
                gradient: const LinearGradient(
                    colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                  //Get.to(CheckoutPage(controller));
                },
              )
            ] else if (isProducts(controller) == false) ...[
              SizedBox(height: 20),
              Text(
                'Your basket',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              BasketProducts(),
              BasketTotal(),
              GradientIconButtonFb7(
                gradient: const LinearGradient(
                    colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
                icon: const Icon(
                  Icons.shopping_cart_checkout_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(CheckoutPage(controller));
                },
              )
            ],
          ]),
        ));
  }
}

class GradientIconButtonFb7 extends StatelessWidget {
  final double radius;
  final Widget icon;
  final LinearGradient gradient;
  final Function() onPressed;

  const GradientIconButtonFb7(
      {required this.gradient,
      required this.icon,
      required this.onPressed,
      this.radius = 48.0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: radius,
      height: radius,
      decoration: ShapeDecoration(
        gradient: gradient,
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: radius / 2,
        iconSize: radius / 2,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
