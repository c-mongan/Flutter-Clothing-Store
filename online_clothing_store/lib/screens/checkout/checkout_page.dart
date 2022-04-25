import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app_fyp/model/user_data.dart';
import 'package:health_app_fyp/screens/payment/payment_page.dart';
import 'package:health_app_fyp/screens/product/product_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';

import '../../constants/layout_constants.dart';
import '../../controllers/basket_controller.dart';
import '../../designpatterns/strategy/delivery_interface.dart';
import '../../designpatterns/strategy/next_day_delivery_strategy.dart';
import '../../designpatterns/strategy/order.dart';
import '../../designpatterns/strategy/order_products.dart';

import '../../designpatterns/strategy/delivery_options.dart';

import '../../designpatterns/strategy/order_info_row.dart';
import '../../designpatterns/strategy/parcel_motel_strategy.dart';
import '../../designpatterns/strategy/standard_delivery_strategy.dart';
import '../../designpatterns/strategy/store_collection_strategy.dart';
import '../../widgets/checkout_products.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../address/address.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage(controller);
  static String id = 'checkout_page';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
  static _CheckoutPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CheckoutPageState>();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  UserInformation loggedInUser = UserInformation();

//List of Different Delivery methods implementing the Strategy Pattern
  final List<InterfaceDeliveryCostsStrategy> _deliveryOptionsList = [
    InStoreCollectionStrategy(),
    ParcelMotelStrategy(),
    PriorityDeliveryStrategy(),
    StandardDeliveryStrategy(),
  ];
  int _selectedDeliveryIndex = 0;
  Order _order = Order();

  void _addToOrder() {
    double total = double.parse(controller.total);
    OrderProducts orderTotal = OrderProducts(price: total);
    _order.addProductToOrder(orderTotal);
    print(controller.total);
  }

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
    _clearOrder();

    if (mounted) {
      setState(() {});
    }
  }

  void _clearOrder() {
    setState(() {
      _order = Order();
    });
  }

  void _setSelectedStrategyIndex(int? index) {
    setState(() {
      _selectedDeliveryIndex = index!;
    });
  }

  void asyncMethod(bool isVisible) async {
    _addToOrder();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key(CheckoutPage.id),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          asyncMethod(isVisible);
        },
        child: Scaffold(
            appBar: const CustomisedAppBar(title: "Checkout"),
            bottomNavigationBar: CustomisedNavigationBar(),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.grey,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SafeArea(
                    child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: LayoutConstants.paddingL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 20),
                        CheckoutProducts(),
                        const SizedBox(height: LayoutConstants.spaceM),
                        Stack(
                          children: <Widget>[
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _order.items.isEmpty ? 1.0 : 0.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Your order is empty',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _order.items.isEmpty ? 0.0 : 1.0,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                      height: LayoutConstants.spaceM),
                                  DeliveryMethods(
                                    selectedIndex: _selectedDeliveryIndex,
                                    deliveryOptions: _deliveryOptionsList,
                                    onChanged: _setSelectedStrategyIndex,
                                  ),
                                  OrderDetails(
                                    deliveryCostStrategy: _deliveryOptionsList[
                                        _selectedDeliveryIndex],
                                    order: _order,
                                  ),
                                  SizedBox(height: 20),
                                  NeumorphicButton(
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (_selectedDeliveryIndex ==
                                                _deliveryOptionsList.length -
                                                    1 ||
                                            _selectedDeliveryIndex ==
                                                _deliveryOptionsList.length -
                                                    2) {
                                          Get.to(AddressPage(controller), arguments: [
                                            _deliveryOptionsList[
                                                _selectedDeliveryIndex],
                                            _order
                                          ]);
                                        } else {
                                          Get.to(PaymentPage(controller), arguments: [
                                            _deliveryOptionsList[
                                                _selectedDeliveryIndex],
                                            _order , controller
                                          ]);
                                        }
                                      }),
                                  SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )))));
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  }
}

class OrderDetails extends StatelessWidget {
  final Order order;
  final InterfaceDeliveryCostsStrategy deliveryCostStrategy;

  const OrderDetails({
    required this.order,
    required this.deliveryCostStrategy,
  });

  double get deliveryCost => deliveryCostStrategy.calculate(order);
  double get total => order.price + deliveryCost;

  double getTotal(
      Order order,
      // ignore: use_function_type_syntax_for_parameters
      InterfaceDeliveryCostsStrategy _deliveryOptionsList(
          [_selectedDeliveryIndex])) {
    return order.price + deliveryCostStrategy.calculate(order);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Details',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            OrderInformationRow(
              fontFamily: 'Montserrat',
              label: 'Subtotal',
              value: order.price,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            OrderInformationRow(
              fontFamily: 'Roboto',
              label: 'Delivery',
              value: deliveryCost,
            ),
            const Divider(),
            OrderInformationRow(
              fontFamily: 'RobotoMedium',
              label: 'Order total',
              value: total,
            ),
          ],
        ),
      ),
    );
  }
}
