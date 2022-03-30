import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/model/product.dart';
import 'package:health_app_fyp/screens/basket/basket_page.dart';

class CustomisedNavigationBar extends StatelessWidget {
  const CustomisedNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey,
      child: SizedBox(
        height: 70,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, "/");
              Get.toNamed('/');
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(BasketPage());
             
             
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/user");
            },
            icon: const Icon(
              Icons.person_outlined,
              color: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
