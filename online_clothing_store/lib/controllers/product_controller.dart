import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../services/database.dart';

class ProductController extends GetxController {
  //List of product objects
  final products = <Product>[].obs;
  final footwear = <Product>[].obs;
  final wishlist = <Product>[].obs;
  // final orderitems= <OrderItem>[].obs;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

//Connects our products list to the database
  @override
  void onInit() {
    products.bindStream(DatabaseService(uid: user!.uid).getAllProducts());
    footwear.bindStream(DatabaseService(uid: user!.uid).getAllFootwear());
    wishlist.bindStream(DatabaseService(uid: user!.uid).getAllWishlist());
    // orderitems.bindStream(FirestoreDB().getAllOrders());

    super.onInit();
  }
}
