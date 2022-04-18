import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final Stream<QuerySnapshot> wishlistStream = FirebaseFirestore.instance
      .collection('wishlist')
      .orderBy("dateTime")
      .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  User? user = FirebaseAuth.instance.currentUser;

  DateTime dateTimeText = DateTime.now();

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
      appBar: const CustomisedAppBar(title: "Wishlist"),
      bottomNavigationBar: const CustomisedNavigationBar(),
      body: WishlistProducts(),
    );
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
