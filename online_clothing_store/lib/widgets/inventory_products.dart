// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_app_fyp/screens/customised_products/customised_products.dart';

// import '../controllers/basket_controller.dart';
// import '../controllers/product_controller.dart';
// import '../screens/product/product_page.dart';

// class InventoryProducts extends StatelessWidget {
//   final productController = Get.put(ProductController());

//   InventoryProducts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: ListView.builder(
//             itemCount: productController.products.length,
//             itemBuilder: (BuildContext context, int index) {
//               return InventoryProductCard(index: index);
//             }),
//       ),
//     );
//   }
// }

// //

// // class InventoryProductCard extends StatelessWidget {
// //   final basketController = Get.put(BasketController());
// //   final ProductController productController = Get.find();
// //   final int index;

// //   InventoryProductCard({
// //     Key? key,
// //     required this.index,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //         padding: const EdgeInsets.symmetric(
// //           horizontal: 20,
// //           vertical: 10,
// //         ),
// //         child: GestureDetector(
// //           behavior: HitTestBehavior.translucent,
// //           onTap: (() {
// //             if (productController.products[index].category == 'custom') {
// //               Get.to(() => (CustomisedProductPage(
// //                   product: productController.products[index])));
// //             } else {
// //               Get.to(() =>
// //                   (ProductPage(product: productController.products[index])));
// //             }
// //           }),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               CircleAvatar(
// //                 radius: 40,
// //                 backgroundImage: NetworkImage(
// //                   productController.products[index].imageUrl,
// //                 ),
// //               ),
// //               SizedBox(width: 20),
// //               Expanded(
// //                 child: Text(
// //                   productController.products[index].name,
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: Text('€ ${productController.products[index].price}'),
// //               ),
// //               IconButton(
// //                 onPressed: () {
// //                   //Adds product to cart
// //                   basketController.addProduct(
// //                       productController.products[index], index);
// //                 },
// //                 icon: const Icon(
// //                   Icons.add_circle,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ));
// //   }
// // }
