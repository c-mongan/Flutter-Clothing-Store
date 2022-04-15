import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import '../../../widgets/custom_products.dart';
import '../../../widgets/shoes_products.dart';
import '../../../widgets/customised_appbar.dart';
import '../../../widgets/customised_navbar.dart';

import '../../basket/basket_page.dart';


class CustomItemPage extends StatelessWidget {
  const CustomItemPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomisedAppBar(title: 'Custom Item'),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                   
                    colors: [
                  Colors.white,
                  Colors.black,
                 

                  // Colors.orange,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SafeArea(
                child: Column(
              children: [
              
                CustomProducts(),
                
              ],
            ))),
      );

  

}
