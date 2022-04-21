import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../model/product.dart';

class CheckoutProducts extends StatelessWidget {
  final BasketController controller = Get.find();

  CheckoutProducts({Key? key}) : super(key: key);

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 200,
          child: Column(children: [
            if (isProducts(controller) == true) ...[
              const SizedBox(height: 100),
              const Text(
                "      ",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ] else ...[
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BasketProductCard(
                      controller: controller,
                      product: controller.products.keys.toList()[index],
                      quantity: controller.products.values.toList()[index],
                      index: index,
                    );
                  }),
            ]
          ]),
        ));
  }
}

class BasketProductCard extends StatelessWidget {
  final BasketController controller;
  final Product product;
  final int quantity;
  final int index;

  const BasketProductCard({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              product.imageUrl!,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              product.name! + "    €" + product.price.toString(),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              "Quantity : $quantity",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
