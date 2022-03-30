import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/product/product_page.dart';

class InventoryProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  InventoryProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child:

            //     GridView.builder(
            // gridDelegate:
            //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return InventoryProductCard(index: index);
                }),
      ),
    );
  }
}

//

class InventoryProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  InventoryProductCard({
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
                (ProductPage(product: productController.products[index])));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  productController.products[index].imageUrl,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  productController.products[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Text('€ ${productController.products[index].price}'),
              ),
              IconButton(
                onPressed: () {
                  //Adds product to cart
                  basketController
                      .addProduct(productController.products[index]);
                },
                icon: const Icon(
                  Icons.add_circle,
                ),
              ),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     padding: const EdgeInsets.all(1.0),
              //     primary: Colors.white,
              //     textStyle: const TextStyle(fontSize: 10),
              //   ),
              //   onPressed: () {
              //     Get.to(() => (ProductPage(
              //         product: productController.products[index])));
              //   },
              //   child: const Text('View'),
              // ),
              // IconButton(
              //   onPressed: () {
              //
              //   },
              //   icon: const Icon(
              //     Icons.add_circle,
              //   ),
              // ),

              // onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ProductPage(
              //             product: productController.products[index]),
            ],
          ),
        ));
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/basket_controller.dart';
// import '../controllers/product_controller.dart';

// class CatalogProducts extends StatelessWidget {
//   final productController = Get.put(ProductController());

//   CatalogProducts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: ListView.builder(
//             itemCount: productController.products.length,
//             itemBuilder: (BuildContext context, int index) {
//               return CatalogProductCard(index: index);
//             }),
//       ),
//     );
//   }
// }

// class CatalogProductCard extends StatelessWidget {

//   final cartController = Get.put(BasketController());
//   final ProductController productController = Get.find();
//   final int index;

//   CatalogProductCard({
//     Key? key,
//     required this.index,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundImage: NetworkImage(
//               productController.products[index].imageUrl,
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Text(
//               productController.products[index].name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text('${productController.products[index].price}'),
//           ),
//           IconButton(
//             onPressed: () {
//               cartController.addProduct(productController.products[index]);
//             },
//             icon: Icon(
//               Icons.add_circle,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
