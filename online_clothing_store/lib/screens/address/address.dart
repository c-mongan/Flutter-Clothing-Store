import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/basket_controller.dart';
import '../../model/user_data.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../home/home_page.dart';
import '../payment/payment_page.dart';

class AddressPage extends StatefulWidget {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  @override
  _AddressPageState createState() => _AddressPageState();
  // static _AddressPageState? of(BuildContext context) =>
  //     context.findAncestorStateOfType<_AddressPageState>();
}

var data = Get.arguments;

// isProducts(data) {
//   if (data.length != 2) {
//     return true;
//   } else {
//     return false;
//   }
// }

final firstNameEditingController = TextEditingController();

final secondNameEditingController = TextEditingController();

final emailEditingController = TextEditingController();

final addressEditingController = TextEditingController();

// final addressEditingController = TextEditingController();

final cityEditingController = TextEditingController();
//EMAIL
final zipCodeEditingController = TextEditingController();
//PASSWORD
final countryEditingController = TextEditingController();
//CONFIRMPASSWORD
final confirmPasswordEditingController = TextEditingController();

class _AddressPageState extends State<AddressPage> {
  // @override

  User? user = FirebaseAuth.instance.currentUser;
  UserInformation loggedInUser = UserInformation();

  @override
  void initState() {
    super.initState();

    // if (mounted) {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());
    });

    setState(() {});
    // }
  }

  void asyncMethod(bool isVisible) async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());

      if (mounted) {
        setState(() {});
      }
    });
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
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
            appBar: CustomisedAppBar(title: 'Address'),
            bottomNavigationBar: CustomisedNavigationBar(),
            // body: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            body: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                // Text(
                //   'CUSTOMER INFORMATION',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black),
                // ),
                // EmailInputFb2(
                //   inputController: TextEditingController(),
                //   text: "Email",
                // ),
                // const SizedBox(height: 20),
                // EmailInputFb2(inputController: TextEditingController(), text: '',),
                SizedBox(height: 20),
                Text(
                  'CUSTOMER INFORMATION',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextBox(
                  inputController: firstNameEditingController,
                  text: "${loggedInUser.firstName}",
                ),

                TextBox(
                  inputController: secondNameEditingController,
                  text: "${loggedInUser.secondName}",
                ),
                TextBox(
                  inputController: emailEditingController,
                  text: "${loggedInUser.email}",
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                Text(
                  'DELIVERY INFORMATION',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextBox(
                  inputController: addressEditingController,
                  text: "${loggedInUser.address}",
                ),
                TextBox(
                  inputController: cityEditingController,
                  text: "${loggedInUser.city}",
                ),
                TextBox(
                  inputController: zipCodeEditingController,
                  text: "${loggedInUser.zipCode}",
                ),
                TextBox(
                  inputController: countryEditingController,
                  text: "${loggedInUser.country}",
                ),
                SizedBox(height: 20),

                NeumorphicButton(
                  child: const Text('Select Payment Method'),
                  onPressed: () {
                    Get.to(PaymentPage(), arguments: [
                      data[0],
                      data[1],
                    ]);
                  },
                ),

                SizedBox(height: 20),
                // Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 60,
                //     alignment: Alignment.bottomCenter,
                //     decoration: BoxDecoration(color: Colors.black),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Center(
                //             //         child: Text(
                //             //           'SELECT A PAYMENT METHOD',
                //             //           style: ,
                //             //         ),
                //             //       ),
                //             //       IconButton(
                //             //         onPressed: () {},
                //             //         icon: Icon(
                //             //           Icons.arrow_forward,
                //             //           color: Colors.white,
                //             //         ),
                //             //       )
                //             //     ],
                //             //   ),
                //             // ),
                //             // SizedBox(height: 20),
                //             ),
                //         // Text(
                //         //   'ORDER SUMMARY',
                //         //   style: TextStyle(
                //         //       fontSize: 20,
                //         //       fontWeight: FontWeight.bold,
                //         //       color: Colors.black),
                //         // ),
                //         // if ((isProducts(data))) ...[
                //         //   const SizedBox(height: 200),
                //         //   const Text(
                //         //     "             Your basket is empty",
                //         //     style: TextStyle(fontSize: 20),
                //         //     textAlign: TextAlign.center,
                //         //   ),
                //         // ] else if (isProducts(data) == false) ...[
                OrderDetails(
                  deliveryCostStrategy: data[0],
                  order: data[1],
                ),
              ],
            ))));
    // ));
    // // ),]

    //     )));
    // ;
    //      ; ]) // <-- wrap this around
    //         ),
    //   );
    // }
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController inputController;
  String text;
  TextBox({Key? key, required this.inputController, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.grey;
    const secondaryColor = Colors.black;
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(.9)),
        ),
        // const SizedBox(
        //   height: 8,
        // ),
        Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: TextField(
            controller: inputController,
            onChanged: (value) {
              //Do something wi
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              label: Text(text),
              labelStyle: const TextStyle(color: primaryColor),
              // prefixIcon: Icon(Icons.email),
              filled: true,
              fillColor: accentColor,
              // hintText: 'support@flutterbricks.com',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
