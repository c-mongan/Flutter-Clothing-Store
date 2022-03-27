
import 'package:flutter/material.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

//class CartPage extends StatefulWidget {
class BasketPage extends StatelessWidget {
//Route name
  static const String routeName = '/basket';

  //Route Method
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => BasketPage());
  }





  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomisedAppBar(title: "Basket"),
        bottomNavigationBar: const CustomisedNavigationBar(),
      );


}
