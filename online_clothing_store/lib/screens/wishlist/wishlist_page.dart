// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:health_app_fyp/widgets/wishlist_products.dart';
// import '../../widgets/customised_appbar.dart';
// import '../../widgets/customised_navbar.dart';

// class WishlistPage extends StatelessWidget {
//   static const String routeName = '/wish';
//  final cartController = Get.put(BasketController());
//   final productController = Get.put(ProductController());
//   final BasketController controller = Get.find();
//   late int index = index;

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) => WishlistPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomisedAppBar(title: "Wishlist"),
//       bottomNavigationBar: CustomisedNavigationBar(),
//       body: SizedBox(
//         child: WishlistProducts(),
//         height: 400,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:health_app_fyp/widgets/wishlist_products.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/basket_products.dart';
import '../../widgets/basket_total.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({Key? key, index}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
  // static _AddressPageState? of(BuildContext context) =>
  //     context.findAncestorStateOfType<_AddressPageState>();
}

class _WishlistPageState extends State<WishlistPage> {
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
    // }
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
            body: SingleChildScrollView(
              child: Column(children: [
                // if (isProducts(controller) == true) ...[
                //   const SizedBox(height: 200),
                //   SizedBox(
                //     height: 20,
                //     width: 40,
                //   ),
                //   const Text(
                //     "             Your basket is empty",
                //     style: TextStyle(fontSize: 20),
                //     textAlign: TextAlign.center,
                //   ),
                //   // SizedBox(
                //   //   height: 70,
                //   //   width: 300,
                //   // ),
                //   // GradientIconButtonFb7(
                //   //   gradient: const LinearGradient(
                //   //       colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
                //   //   icon: const Icon(
                //   //     Icons.arrow_back,
                //   //     color: Colors.white,
                //   //   ),
                //   //   onPressed: () {
                //   //     Get.to(HomePage());
                //   //     //Get.to(CheckoutPage(controller));
                //   //   },
                //   // )
                // ] else if (isProducts(controller) == false) ...[
                //   SizedBox(height: 20),
                //   Text(
                //     'Your basket',
                //     style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black),
                //   ),
                //   WishlistProducts(),

                //   NeumorphicButton(
                //     child: Text("Continue"),
                //     onPressed: () {
                //       if (controller.products.length != 0) {
                //         Get.to(CheckoutPage(controller));
                //       } else if (controller.products.length == 0) {
                //         Get.to(HomePage());
                //       }
                //       //Get.to(CheckoutPage(controller));
                //     },
                //   )

                //   // GradientIconButtonFb7(
                //   //   gradient: const LinearGradient(
                //   //       colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
                //   //   icon:  Icon(

                //   //     Icons.shopping_cart_checkout_sharp,
                //   //     color: Colors.white,
                //   //   ),
                //   //   onPressed: () {
                //   //     if (controller.products.length != 0) {
                //   //       Get.to(CheckoutPage(controller));
                //   //     } else if (controller.products.length == 0) {
                //   //       Get.to(HomePage());
                //   //     }
                //   //     //Get.to(CheckoutPage(controller));
                //   //   },
                //   // ),
                //   // if (isProducts(controller) == false) ...[
                //   //   GradientIconButtonFb7(
                //   //     gradient: const LinearGradient(
                //   //         colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
                //   //     icon: const Icon(
                //   //       Icons.shopping_cart_checkout_sharp,
                //   //       color: Colors.white,
                //   //     ),
                //   //     onPressed: () {
                //   //       Get.to(CheckoutPage(controller));
                //   //     },
                //   //   )
                //   // ]
                // ]
                SizedBox(
                  height: 1000,
                  child: WishlistProducts(),
                ),
              ]),
            )));
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
