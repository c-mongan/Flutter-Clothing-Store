import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/customised_products/customised_products.dart';


class CustomProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  CustomProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.custom.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomProductCard(index: index);
            }),
      ),
    );
  }
}

//

class CustomProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  CustomProductCard({
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
              Get.to(() => (CustomisedProductPage(
                  product: productController.custom[index])));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    productController.custom[index].imageUrl!,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    productController.custom[index].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('€ ${productController.custom[index].price}'),
                ),
                IconButton(
                  onPressed: () {
                    //Adds product to cart
                    basketController.addProduct(
                        productController.custom[index], index);
                  },
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                ),
              ],
            )));
  }
}
