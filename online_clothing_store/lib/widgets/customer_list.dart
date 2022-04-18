import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/customer_controllers.dart';
import '../model/product.dart';

class CustomerListCard extends StatelessWidget {
  // final basketController = Get.put(BasketController());
  final UserController customerController = Get.find();
  final int index;

  CustomerListCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (() {
            //If the item is not in the custom items category, then navigate to the product page
            // Get.to(() =>
            //     (ProductPage(product: customerController.users[index])));
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   "userID: " +
              //       customerController.users
              //           .indexOf(customerController.users[index])
              //           .toString(),
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //       color: Colors.white),
              // ),
              Text(
                "ID : " + customerController.users[index].uid!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 7,
                    color: Colors.white),
              ),
              Text(
                customerController.users[index].firstName! +
                    " " +
                    customerController.users[index].secondName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text("",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }
}
