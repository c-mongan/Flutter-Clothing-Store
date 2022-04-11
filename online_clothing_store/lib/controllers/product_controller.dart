import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../services/database.dart';

class ProductController extends GetxController {
  //List of product objects
  late var products = <Product>[].obs;
  final footwear = <Product>[].obs;
  final wishlist = <Product>[].obs;
  final custom = <Product>[].obs;
  // final orderitems= <OrderItem>[].obs;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

//Connects our products list to the database
  @override
  void onInit() {
    products.bindStream(DatabaseService(uid: user!.uid).getAllProducts());
    footwear.bindStream(DatabaseService(uid: user!.uid).getAllFootwear());
    wishlist.bindStream(DatabaseService(uid: user!.uid).getAllWishlist());
    custom.bindStream(DatabaseService(uid: user!.uid).getAllCustom());
    // orderitems.bindStream(FirestoreDB().getAllOrders());

    super.onInit();
  }

  void searchProducts(String searchText) {
    searchText = searchText.toLowerCase();

    List<String> manufacturers = ["manufacturer", "CM Clothing"];

    if (searchText.isEmpty) {
      return products
          .bindStream(DatabaseService(uid: user!.uid).getAllProducts());
    } else if (searchText == 'a' ||
        searchText == 'b' ||
        searchText == 'c' ||
        searchText == 'd' ||
        searchText == 'e' ||
        searchText == 'f' ||
        searchText == 'g' ||
        searchText == 'h' ||
        searchText == 'i' ||
        searchText == 'j' ||
        searchText == 'k' ||
        searchText == 'l' ||
        searchText == 'm' ||
        searchText == 'n' ||
        searchText == 'o' ||
        searchText == 'p' ||
        searchText == 'q' ||
        searchText == 'r' ||
        searchText == 's' ||
        searchText == 't' ||
        searchText == 'u' ||
        searchText == 'v' ||
        searchText == 'w' ||
        searchText == 'x' ||
        searchText == 'y' ||
        searchText == 'z') {
      products.bindStream(
          DatabaseService(uid: user!.uid).getAllProducts().map((list) {
        return list
            .where((product) => product.name.contains(searchText))
            .toList();
      }));
//Add all categories types here to search for them
      if (searchText == 'a' ||
          searchText == 'b' ||
          searchText == 'c' ||
          searchText == 'd' ||
          searchText == 'e' ||
          searchText == 'f' ||
          searchText == 'g' ||
          searchText == 'h' ||
          searchText == 'i' ||
          searchText == 'j' ||
          searchText == 'k' ||
          searchText == 'l' ||
          searchText == 'm' ||
          searchText == 'n' ||
          searchText == 'o' ||
          searchText == 'p' ||
          searchText == 'q' ||
          searchText == 'r' ||
          searchText == 's' ||
          searchText == 't' ||
          searchText == 'u' ||
          searchText == 'v' ||
          searchText == 'w' ||
          searchText == 'x' ||
          searchText == 'y' ||
          searchText == 'z') {
        products.bindStream(
            DatabaseService(uid: user!.uid).getAllProducts().map((list) {
          //Concatonates all matching categories and names into one list and removes duplicates
          List<Product> newList = list
                  .where((product) => product.category.contains(searchText))
                  .toSet()
                  .toList() +
              list
                  .where((product) => product.name.contains(searchText))
                  .toSet()
                  .toList();
          return newList.toSet().toList();
        }));

//Add all manufacturer names here to search for them

        if (searchText == (manufacturers[0]) ||
            searchText == (manufacturers[1])) {
          products.bindStream(
              DatabaseService(uid: user!.uid).getAllProducts().map((list) {
            return list
                .where((product) => product.manufacturer == searchText)
                .toList();
          }));

        
        }
      }
    }
  }
}
