import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:health_app_fyp/widgets/customer_list.dart';
import 'package:health_app_fyp/widgets/wishlist_products.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../controllers/customer_controllers.dart';
import '../../../widgets/customised_appbar.dart';
import '../../../widgets/customised_navbar.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key? key, index}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final UserController customerController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomisedAppBar(title: "Customers"),
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
                  child: Column(
            children: <Widget>[
              
              SizedBox(
                  height: 300,
                  child: Obx(
                    () => Flexible(
                      child: ListView.builder(
                          itemCount: customerController.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomerListCard(index: index);
                          }),
                    ),
                  )),
            ],
          )))),
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
