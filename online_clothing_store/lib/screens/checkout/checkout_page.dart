import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/widgets/basket_products.dart';

import '../../constants/layout_constants.dart';
import '../../controllers/basket_controller.dart';
import '../../designpatterns/delivery_interface.dart';
import '../../designpatterns/order/order.dart';
import '../../designpatterns/order/order_products.dart';
import '../../designpatterns/strategies/store_collection_strategy.dart';
import '../../designpatterns/strategies/parcel_motel_strategy.dart';
import '../../designpatterns/strategies/next_day_delivery_strategy.dart';
import '../../designpatterns/strategy/order/order_summary/order_summary.dart';
import '../../designpatterns/strategy/delivery_options.dart';
import '../../widgets/checkout_products.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage(controller);
  static String id = 'checkout_page';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final cartController = Get.put(BasketController());
  final BasketController controller = Get.find();

  final List<InterfaceDeliveryCostsStrategy> _shippingCostsStrategyList = [
    InStoreCollectionStrategy(),
    ParcelMotelStrategy(),
    PriorityDeliveryStrategy(),
  ];
  int _selectedStrategyIndex = 0;
  Order _order = Order();

  void _addToOrder() {
    //setState(() {
    double total = double.parse(controller.total);
    OrderProducts orderTotal = OrderProducts(price: total);
    _order.addProductToOrder(orderTotal);
    print(controller.total);

    //_order.addOrderItem();
    // });
  }

  @override
  void initState() {
    super.initState();

    _clearOrder();
    if (mounted) {
      //check whether the state object is in tree

      //_addToOrder();

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
      _selectedStrategyIndex = index!;
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
            body: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: LayoutConstants.paddingL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CheckoutProducts(),

                    // OrderButtons(
                    //   onAdd: _addToOrder,
                    //   onClear: _clearOrder,
                    // ),
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
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _order.items.isEmpty ? 0.0 : 1.0,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: LayoutConstants.spaceM),
                              DeliveryMethods(
                                selectedIndex: _selectedStrategyIndex,
                                deliveryOptions: _shippingCostsStrategyList,
                                onChanged: _setSelectedStrategyIndex,
                              ),
                              OrderDetails(
                                shippingCostStrategy:
                                    _shippingCostsStrategyList[
                                        _selectedStrategyIndex],
                                order: _order,
                              ),
                              // Text(
                              //   'Total' + controller.total.toString(),
                              //   style: TextStyle(
                              //     fontSize: 24,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  }
}
