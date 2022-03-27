import 'package:flutter/material.dart';


import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';

class InventoryPage extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => InventoryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomisedAppBar(title: "Catalogue"),
      bottomNavigationBar: const CustomisedNavigationBar(),
    );
  }
}
