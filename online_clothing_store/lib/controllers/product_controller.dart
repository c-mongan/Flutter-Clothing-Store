
import 'package:get/get.dart';

import '../model/product.dart';
import '../services/database.dart';

class ProductController extends GetxController {
 //List of product objects
  final products = <Product>[].obs;

//Connects our products list to the database
  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}


