import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';

class BasketTotal extends StatelessWidget {
  final BasketController controller = Get.find();
  BasketTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (isProducts(controller) == true) ...[
              const SizedBox(height: 80),
              // const Text(
              //   "                     Your basket is empty",
              //   style: TextStyle(fontSize: 20),
              //   textAlign: TextAlign.center,
            ] else ...[
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\€${controller.total}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ]),
        ));
  }

  isProducts(BasketController controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }
}
