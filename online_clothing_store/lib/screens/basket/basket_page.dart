import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/basket_products.dart';
import '../../widgets/basket_total.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class BasketPage extends StatefulWidget {
  BasketPage({Key? key, index}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  static const String routeName = '/basket';
  final cartController = Get.put(BasketController());
  final productController = Get.put(ProductController());
  final BasketController controller = Get.find();
  late int index = index;

  @override
  void initState() {
    super.initState();

    isProducts(controller);

    setState(() {});
  }

  void asyncMethod(bool isVisible) async {
    isProducts(controller);

    if (mounted) {
      setState(() {});
    }
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  }

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key("key"),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          asyncMethod(isVisible);
        },
        child: Scaffold(
            appBar: const CustomisedAppBar(title: "Basket"),
            bottomNavigationBar: const CustomisedNavigationBar(),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.grey,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    if (isProducts(controller) == true) ...[
                      const SizedBox(height: 200),
                      SizedBox(
                        height: 20,
                        width: 40,
                      ),
                      const Text(
                        "Empty",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ] else if (isProducts(controller) == false) ...[
                      SizedBox(height: 20),
                      BasketProducts(),
                      BasketTotal(),
                      NeumorphicButton(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (controller.products.length != 0) {
                            Get.to(CheckoutPage(controller));
                          } else if (controller.products.length == 0) {
                            Get.to(HomePage());
                          }
                        },
                      )
                    ]
                  ]),
                )))));
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
