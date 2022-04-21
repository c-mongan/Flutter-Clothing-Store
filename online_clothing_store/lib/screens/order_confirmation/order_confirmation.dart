import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';

import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../model/user_model.dart';
import '../../widgets/checkout_products.dart';
import '../admin/admin_inventory/admin_product.dart';
import '/widgets/widgets.dart';

// ignore: must_be_immutable
class OrderConfirmation extends StatelessWidget {
  OrderConfirmation(BasketController controller, {Key? key}) : super(key: key);
  var data = Get.arguments;
  int orderNo = Random().nextInt(100000);
  final cartController = Get.put(BasketController());
  final productController = Get.put(ProductController());
  final BasketController controller = Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomisedAppBar(title: 'Order Confirmation'),
        bottomNavigationBar: CustomisedNavigationBar(),
        extendBodyBehindAppBar: true,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black,
              Colors.grey,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 1000,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Your order is complete!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thank you for purchasing from our store!',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'ORDER CODE: #${orderNo}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          CheckoutProducts(),
                          Divider(thickness: 2),
                          SizedBox(height: 5),
                          OrderDetails(
                              order: data[1], deliveryCostStrategy: data[0]),
                          Center(
                            child: NeumorphicButton(
                              child: Text(
                                'Back to Home',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => addOrder(controller, orderNo),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  void addOrder(BasketController controller, orderNo) {
    for (int i = 0; i < controller.products.length; i++) {
      print(controller.products.length);

      addFirestore(i, orderNo, controller);
    }

    Get.to(const HomePage());

    controller.products.clear();
  }

  void addFirestore(i, orderNo, controller) async {
    String uid = controller.products.keys.toList()[i].itemID.toString();

    FirebaseFirestore.instance
        .collection("orders")
        .doc(orderNo.toString())
        .set({
      "orderNo": orderNo,
      "total": controller.total,
      "userID": user?.uid,
      "products": [
        {
          "itemID": uid,
          "name": controller.products.keys.toList()[i].name,
          "price": controller.products.keys.toList()[i].price,
          "quantity": controller.products.values.toList()[i],
          "image": controller.products.keys.toList()[i].imageUrl,
        }
      ],
      "dateTime": DateTime.now(),
    });

    FirebaseFirestore.instance.collection("orderItems").doc().set({
      "name": controller.products.keys.toList()[i].name,
      "price": controller.products.keys.toList()[i].price,
      "color1": controller.products.keys.toList()[i].color,
      "color2": controller.products.keys.toList()[i].color2,
      "stock": controller.products.keys.toList()[i].stock,
      "img": controller.products.keys.toList()[i].imageUrl,
      "quantity": controller.products.values.toList()[i],
      "id": orderNo.toString(),
      "uid": uid,
      "dateTime": DateTime.now(),
    });

//Decrement stock level
    int quantity = controller.products.values.toList()[i];
    await FirebaseFirestore.instance
        .collection('product')
        .doc(uid)
        .update({'stock': FieldValue.increment(-quantity)})
        .then((value) => print("Product Updated"))
        .catchError((error) => print("Failed to update product: $error"));
  }
}
