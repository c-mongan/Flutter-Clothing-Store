import 'package:flutter/material.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class CheckoutPage extends StatelessWidget {
  static const String routeName = '/checkout';

  CheckoutPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomisedAppBar(title: "checkout"),
      bottomNavigationBar: CustomisedNavigationBar(),
    );
  }
}
