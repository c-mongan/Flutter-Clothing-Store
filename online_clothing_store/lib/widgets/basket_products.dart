import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../model/product.dart';

class BasketProducts extends StatelessWidget {
  final BasketController controller = Get.find();

  BasketProducts({Key? key}) : super(key: key);

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Obx allows us to see the changes in the basket (Product dictionary _products)
    return Obx(() => SizedBox(
          height: 500,
          child: Column(children: [
            if (isProducts(controller) == true) ...[
              const Text("Empty"),
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
              product.imageUrl,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(product.name),
          ),
          IconButton(
            onPressed: () {
              controller.removeProduct(product);
            },
            icon: Icon(Icons.remove_circle),
          ),
          Text('$quantity'),
          IconButton(
            onPressed: () {
              controller.addProduct(product);
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}
