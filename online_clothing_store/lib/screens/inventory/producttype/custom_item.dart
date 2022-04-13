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

//class HomePage extends StatefulWidget {
class CustomItemPage extends StatelessWidget {
  const CustomItemPage({Key? key}) : super(key: key);


//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();

  // @override
  // void initState() {

  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     loggedInUser = UserModel.fromMap(value.data());
  //       super.initState();

  //     setState(() {});

  //   });
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomisedAppBar(title: 'Custom Item'),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    // colors: [Colors.red, Colors.white, Colors.red],
                    colors: [
                  Colors.white,
                  Colors.black,
                  // Colors.red,
                  //Colors.blue,

                  // Colors.orange,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SafeArea(
                child: Column(
              children: [
                //InventoryProducts(),
                CustomProducts(),
                // CatalogProducts(),

                //             ElevatedButton(
                //                 // onPressed: () => Get.to(() => BasketPage()),
                //                 // child: const Text("Go to Cart")),

                //                 onPressed: () {
                //   Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //       builder: (context) => BasketPage(),
                //     ),
                //   );
                // },
                //                 child: const Text("Go to Cart")),
              ],
            ))),
      );

  // child: Center(
  //   child: Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         SizedBox(
  //           height: 55,
  //           child: Text(
  //             "Welcome !",
  //             // "Welcome ${loggedInUser.firstName} ${loggedInUser.secondName}!",
  //             style: const TextStyle(
  //                 fontSize: 25,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         const SizedBox(
  //           height: 120,
  //           // child: Image.asset("assets/healthy1.png",
  //           //     fit: BoxFit.contain)
  //         ),
  //         // ignore: prefer_const_constructors

  //         // ignore: prefer_const_constructors
  //         SizedBox(
  //           height: 25,
  //         ),
  //         Text("Your Name:",
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w500,
  //             )),
  //         Text("Your E-mail: ",
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w500,
  //             )),
  //         const SizedBox(
  //           height: 25,
  //         ),
  //         ActionChip(
  //             label: const Text("Log Out"),
  //             labelStyle:
  //                 const TextStyle(color: Colors.white, fontSize: 15),
  //             backgroundColor: Colors.red,
  //             onPressed: () {
  //               logout(context);
  //             }),
  //       ],
  //     ),
  //   ),
  // ),

}
