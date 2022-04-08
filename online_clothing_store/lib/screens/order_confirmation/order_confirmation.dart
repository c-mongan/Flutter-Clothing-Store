import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import '/widgets/widgets.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';
  var data = Get.arguments;
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomisedAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: CustomisedNavigationBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                // Positioned(
                //   left: (MediaQuery.of(context).size.width - 100) / 2,
                //   top: 125,
                //   child: SvgPicture.asset(
                //     'assets/svgs/garlands.svg',
                //     height: 100,
                //     width: 100,
                //   ),
                // ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Conor ,',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thank you for purchasing from our store.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headline5,
                  ),

                  // SizedBox(height: 20),
                  // Text(
                  //   'ORDER DETAILS',
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
                  Divider(thickness: 2),
                  SizedBox(height: 5),
                  OrderDetails(order: data[1], deliveryCostStrategy: data[0]),
                  // ListView(
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   children: [
                  //     // OrderSummaryProductCard(
                  //     //   product: Product.products[0],
                  //     //   quantity: 2,
                  //     // ),
                  //     // OrderSummaryProductCard(
                  //     //   product: Product.products[1],
                  //     //   quantity: 3,
                  //     // OrderProducts(price: price)
                  //   ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
