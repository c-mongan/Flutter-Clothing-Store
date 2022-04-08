import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';

import '../../constants/layout_constants.dart';
import '../../controllers/basket_controller.dart';
import '../../designpatterns/strategy/delivery_interface.dart';
import '../../designpatterns/strategy/order.dart';
import '../../designpatterns/strategy/order_products.dart';

import '../../designpatterns/strategy/delivery_options.dart';
import '../../widgets/checkout_products.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../checkout/checkout_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  static String id = 'checkout_page';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  void _setSelectedStrategyIndex(int? index) {
    setState(() {
      _selectedIndex = index!;
    });
  }

  List paymentOptions = [
    "Paypal",
    "Card",
    // "Cash",
    // "Bank Transfer",
    "Cash on Delivery",
    "Bitcoin"
  ];

  int _selectedIndex = 0;
  late ValueChanged<int?> onChanged;

  var data = Get.arguments;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {});
    }
  }

  void asyncMethod(bool isVisible) async {
    if (isVisible) {
      print('visible');
    } else {
      print('not visible');
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(PaymentPage.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        asyncMethod(isVisible);
      },
      child: Scaffold(
        appBar: const CustomisedAppBar(title: "Checkout"),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   child: Text(data[0].toString()), // first element set here
            // ),
            // Text(data[1].toString()), // second element set here

            for (var i = 0; i < paymentOptions.length; i++)
              RadioListTile<int>(
                title: Text(paymentOptions[i]),
                value: i,
                groupValue: _selectedIndex,
                onChanged: _setSelectedStrategyIndex,
                dense: true,
                activeColor: Colors.black,
              ),

            OutlinedButton(
              onPressed: () {
                debugPrint('Received click');

                if (_selectedIndex == 0) {
                  print("Paypal");
                } else if (_selectedIndex == 1) {
                  print("Card");
                } else if (_selectedIndex == 2) {
                  print("Cash on Delivery");
                } else if (_selectedIndex == 3) {
                  print("Bitcoin");
                }
              },
              child: const Text('Pay Now'),
            ),

            const SizedBox(height: LayoutConstants.spaceM),

            OrderDetails(
              deliveryCostStrategy: data[0],
              order: data[1],
            ),
          ],
        ),
      ),
    );
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  }
}
