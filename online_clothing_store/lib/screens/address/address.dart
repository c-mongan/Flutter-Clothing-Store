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
  AddressPage(BasketController controller, {Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

final cartController = Get.put(BasketController());
final BasketController controller = Get.find();

var data = Get.arguments;

final firstNameEditingController = TextEditingController();

final secondNameEditingController = TextEditingController();

final emailEditingController = TextEditingController();

final addressEditingController = TextEditingController();

final cityEditingController = TextEditingController();

final zipCodeEditingController = TextEditingController();

final countryEditingController = TextEditingController();

final confirmPasswordEditingController = TextEditingController();

class _AddressPageState extends State<AddressPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserInformation loggedInUser = UserInformation();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());
    });

    setState(() {});
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
            body: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'CUSTOMER INFORMATION',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextBox(
                  label: "First name",
                  inputController: firstNameEditingController,
                  text: "${loggedInUser.firstName}",
                ),
                TextBox(
                  label: "Last name",
                  inputController: secondNameEditingController,
                  text: "${loggedInUser.secondName}",
                ),
                TextBox(
                  label: "Email",
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
                  label: "Address",
                  inputController: addressEditingController,
                  text: "${loggedInUser.address}",
                ),
                TextBox(
                  label: "City",
                  inputController: cityEditingController,
                  text: "${loggedInUser.city}",
                ),
                TextBox(
                  label: "Zip code",
                  inputController: zipCodeEditingController,
                  text: "${loggedInUser.zipCode}",
                ),
                TextBox(
                  label: "Country",
                  inputController: countryEditingController,
                  text: "${loggedInUser.country}",
                ),
                SizedBox(height: 20),
                NeumorphicButton(
                  child: const Text(
                    'Select Payment Method',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("UserData")
                        .doc(user?.uid)
                        .set({
                      'uid': user?.uid,
                      'firstName': firstNameEditingController.text,
                      'secondName': secondNameEditingController.text,
                      'email': emailEditingController.text,
                      'address': addressEditingController.text,
                      'city': cityEditingController.text,
                      'zipCode': zipCodeEditingController.text,
                      'country': countryEditingController.text,
                    });
                    Get.to(PaymentPage(controller),
                        arguments: [data[0], data[1], controller]);
                  },
                ),
                SizedBox(height: 20),
                OrderDetails(
                  deliveryCostStrategy: data[0],
                  order: data[1],
                ),
              ],
            ))));
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController inputController;
  String text;
  String label;
  TextBox(
      {Key? key,
      required this.inputController,
      required this.text,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.grey;
    const secondaryColor = Colors.black;
    const accentColor = Color(0xffffffff);
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
            onChanged: (value) {},
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              label: Text(label),
              labelStyle: const TextStyle(color: primaryColor),
              filled: true,
              fillColor: accentColor,
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
