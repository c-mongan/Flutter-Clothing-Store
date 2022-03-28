import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';

class InventoryProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  InventoryProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Obx(
          () =>
        Flexible(
      child: ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (BuildContext context, int index) {
            return InventoryProductCard(index: index);
          }),
    )
    ,
    );
  }
}

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
              basketController.addProduct(productController.products[index]);
            },
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ],
      ),
    );
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
