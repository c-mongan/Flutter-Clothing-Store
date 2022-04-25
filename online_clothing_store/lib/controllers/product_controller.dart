import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../services/database.dart';

class ProductController extends GetxController {
  //List of product objects
  late var products = <Product>[].obs;
  final wishlist = <Product>[].obs;
  final custom = <Product>[].obs;
  final upperwear = <Product>[].obs;
  final lowerwear = <Product>[].obs;
  var db = DatabaseService(uid:"");
  

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

//Connects our products list to the database
  @override
  void onInit() {
    

    var db = DatabaseService(uid: user!.uid);
    //Stream of products from the database
    products.bindStream(db.getAllProducts());
    //Stream of products from the database by title (Ascending)
    products
        .bindStream(db.getAllProductsByTitleAsc());
    //Stream of products from the database by title (Descending)
    products.bindStream(
        db.getAllProductsByTitleDesc());
    //Stream of products from the database by manufacturer (Descending)
    products.bindStream(
        db.getAllProductsByManufacturerDesc());
    //Stream of products from the database by manufacturer (Ascending)
    products.bindStream(
        db.getAllProductsByManufacturerAsc());
    //Stream of products from the database by price (Ascending)
    products
        .bindStream(db.getAllProductsByPriceAsc());
    //Stream of products from the database by price (Descending)
    products.bindStream(
        db.getAllProductsByPriceDesc());

    custom.bindStream(db.getAllCustom());

    upperwear.bindStream(db.getAllUpperWear());

    lowerwear.bindStream(db.getAllLowerWear());

    super.onInit();
  }

  Stream<List<Product>> getStream(String filterCriterea ,) {
    // print(filterCriterea + " Filter Criterea");
    

    switch (filterCriterea) {
      case "title ascending":
        return db.getAllProductsByTitleAsc();

      case "title descending":
        return db.getAllProductsByTitleDesc();

      case "manufacturer ascending":
        return db
            .getAllProductsByManufacturerAsc();

      case "manufacturer descending":
        return db
            .getAllProductsByManufacturerDesc();

      case "price ascending":
        return db.getAllProductsByPriceAsc();

      case "price descending":
        return db.getAllProductsByPriceDesc();

      case "":
        return db.getAllProducts();

      default:
        return db.getAllProducts();
    }

   
  }

  void searchProducts(String searchText, String setFilterCriterea) {
    String filterCriterea = setFilterCriterea.toLowerCase();
    searchText = searchText.toLowerCase();

    getStream(filterCriterea);

    List<String> manufacturers = [];
    List<String> categories = [];
    List<String> titles = [];

    for (var i = 0; i < products.length; i++) {
      manufacturers.add(products[i].manufacturer! + "");
      categories.add(products[i].category! + "");
      titles.add(products[i].name! + "");
    }

    check(String value) => value.contains(searchText);
    manufacturers.any(check);
    categories.any(check);
    titles.any(check);

    if (searchText == " ") {
      return products.bindStream(getStream(filterCriterea));
    } else // ***TO Do*** Add all manufacturer names here to search for them

    if (searchText == manufacturers.any.toString().toLowerCase() ||
        searchText == categories.any.toString().toLowerCase() ||
        searchText == titles.any.toString().toLowerCase()) {
      print("matched manufacturer");
      products.bindStream(getStream(filterCriterea).map((list) {
        return list
            .where(
                (product) => product.manufacturer!.toLowerCase() == searchText)
            .toList();
      }));
    } else if (searchText == titles.any(check).toString().toLowerCase()) {
      products.bindStream(getStream(filterCriterea).map((list) {
        print("matched titles");
        return list
            .where(
                (product) => product.name!.toLowerCase().contains(searchText))
            .toList();
      }));
    } else
//Add all categories types here to search for them
    if (searchText == categories.any(check).toString().toLowerCase()) {
      products.bindStream(getStream(filterCriterea).map((list) {
        print("matched categories");
        //Concatonates all matching categories and names into one list and removes duplicates
        List<Product> newList = list
                .where((product) =>
                    product.category!.toLowerCase().contains(searchText))
                .toSet()
                .toList() +
            list
                .where((product) =>
                    product.name!.toLowerCase().contains(searchText))
                .toSet()
                .toList();
        return newList.toSet().toList();
      }));
    } else {
      return products.bindStream(getStream(filterCriterea));
    }
  }
}
