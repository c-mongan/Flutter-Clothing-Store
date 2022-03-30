import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/product.dart';

class BasketController extends GetxController {
  // This dict will be used to check the products already in the cart.
  // .obs Allows us to view value from outside the screen.
  final _products = {}.obs;

//Adds product to cart
  void addProduct(Product product) {
    //If product already in the cart, increase the quantity
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      //Else if it is not in the cart, add it to the cart
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added",
      "You have added the ${product.name} to the basket",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  // bool isProducts(_products) {
  //   if (_products.isEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
}
// }
