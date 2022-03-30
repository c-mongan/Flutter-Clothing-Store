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
        child: 
      

            
            //     GridView.builder(
            // gridDelegate:
            //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                ListView.builder(
            itemCount: productController.fruits.length,
            itemBuilder: (BuildContext context, int index) {
              return FruitProductCard(index: index);
            }),
      ),
    );
  }
}

//

class FruitProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  FruitProductCard({
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
              productController.fruits[index].imageUrl,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              productController.fruits[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Text('€ ${productController.fruits[index].price}'),
          ),
          IconButton(
            onPressed: () {
              //Adds product to cart
              basketController.addProduct(productController.fruits[index]);
            },
            icon: const Icon(
              Icons.add_circle,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/product',
                  arguments: productController.fruits[index]);
            },

            // onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ProductPage(
            //             product: productController.fruits[index]),
            icon: const Icon(
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
//             itemCount: productController.fruits.length,
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
//               productController.fruits[index].imageUrl,
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Text(
//               productController.fruits[index].name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text('${productController.fruits[index].price}'),
//           ),
//           IconButton(
//             onPressed: () {
//               cartController.addProduct(productController.fruits[index]);
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
