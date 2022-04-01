import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';

import '../../constants/layout_constants.dart';
import '../../controllers/basket_controller.dart';
import '../../designpatterns/delivery_interface.dart';
import '../../designpatterns/order/order.dart';
import '../../designpatterns/order/order_products.dart';
import '../../designpatterns/strategies/standard_delivery_strategy.dart';
import '../../designpatterns/strategies/store_collection_strategy.dart';
import '../../designpatterns/strategies/parcel_motel_strategy.dart';
import '../../designpatterns/strategies/next_day_delivery_strategy.dart';
import '../../designpatterns/strategy/delivery_options.dart';
import '../../widgets/checkout_products.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../checkout/checkout_page.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);
  static String id = 'checkout_page';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

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
        bottomNavigationBar: CustomisedNavigationBar(),
        body:

            // ScrollConfiguration(
            //   behavior: const ScrollBehavior(),
            //   child: SingleChildScrollView(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: LayoutConstants.paddingL,
            //     ),
            //     child:
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(data[0].toString()), // first element set here
            ),
            Text(data[1].toString()), // second element set here

            SizedBox(height: LayoutConstants.spaceM),
         
                OrderDetails(
                  deliveryCostStrategy:
                     data[0],
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
