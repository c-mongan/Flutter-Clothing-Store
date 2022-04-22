import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/model/user_data.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:health_app_fyp/widgets/customer_list.dart';
import 'package:health_app_fyp/widgets/wishlist_products.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../controllers/customer_controllers.dart';
import '../../../widgets/customised_appbar.dart';
import '../../../widgets/customised_navbar.dart';
import '../../constants/style.dart';

class AdminCustomerDetails extends StatefulWidget {
  final UserInformation customer;
  AdminCustomerDetails({Key? key, index, required this.customer})
      : super(key: key);

  @override
  _AdminCustomerDetailsState createState() => _AdminCustomerDetailsState();
}

class _AdminCustomerDetailsState extends State<AdminCustomerDetails> {
  final UserController customerController = Get.put(UserController());

  late final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
      .collection('orders')
      .orderBy("orderNo", descending: true)
      .where('userID', isEqualTo: widget.customer.uid)
      .snapshots();

  late final Stream<QuerySnapshot> ordersItemsStream = FirebaseFirestore
      .instance
      .collection('orderItems')
      .orderBy("orderNo", descending: true)
      .where('userID', isEqualTo: widget.customer.uid)
      .snapshots();
  List<dynamic> alldata = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomisedAppBar(title: "{widget.customer.name}"),
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
              CustomerInfo(customer: widget.customer),
              SizedBox(height: 20),
              SizedBox(
                  height: 500.0,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: ordersStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      return Container(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              title: Text(
                                "Order #" +
                                    data['orderNo'].toString() +
                                    "        " +
                                    "€ " +
                                    (data['total']),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              isThreeLine: true,
                              subtitle: Text(
                                // data['review'].toString(),
                                "",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: data['products'] != null
                                  ? Text(
                                      "Number of products " +
                                          data['products'].length.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  : Text("Number of products " + "0",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                            );
                          }).toList(),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black26))),
                      );
                      ;
                    },
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

class CustomerInfo extends StatelessWidget {
  final UserInformation customer;
  const CustomerInfo({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("Customer ID : ${customer.uid}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Name :" + customer.firstName! + " " + customer.secondName!,
          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Text(
          "Email :" + customer.email!,

          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Text(
          "Address :" + customer.address!,
          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Text(
          "City :" + customer.city!,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Text(
          "Primary Card Number :" + customer.cardNum!,
          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
        ),
        Text(
          "Cvv :" + customer.cvv!,
          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        Text(
          "Expiry Date :" + customer.expiryDate!,

          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}
