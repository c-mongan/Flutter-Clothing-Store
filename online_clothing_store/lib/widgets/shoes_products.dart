import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/product/product_page.dart';

class ShoesProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  ShoesProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.footwear.length,
            itemBuilder: (BuildContext context, int index) {
              return ShoesProductCard(index: index);
            }),
      ),
    );
  }
}

//

class ShoesProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  ShoesProductCard({
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
                  (ProductPage(product: productController.footwear[index])));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    productController.footwear[index].imageUrl!,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    productController.footwear[index].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('€ ${productController.footwear[index].price}'),
                ),
                IconButton(
                  onPressed: () {
                    //Adds product to cart
                    basketController.addProduct(
                        productController.footwear[index], index);
                  },
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                ),
              ],
            )));
  }
}
