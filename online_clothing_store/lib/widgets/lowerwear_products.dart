import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/customised_products/customised_products.dart';
import '../screens/product/lowerwear_product_page.dart';
import '../screens/product/product_page.dart';

class LowerwearProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  LowerwearProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.lowerwear.length,
            itemBuilder: (BuildContext context, int index) {
              return LowerwearProductCard(index: index);
            }),
      ),
    );
  }
}

//

class LowerwearProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  LowerwearProductCard({
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
            onTap: () {
              Get.to(() =>
                  (LowerwearProductPage(product: productController.lowerwear[index])));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    productController.lowerwear[index].imageUrl!,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    productController.lowerwear[index].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('€ ${productController.lowerwear[index].price}'),
                ),
                IconButton(
                  onPressed: () {
                    //Adds product to cart
                    basketController.addProduct(
                        productController.lowerwear[index], index);
                  },
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                ),
              ],
            )));
  }
}
