import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product.dart';
import '../model/user_data.dart';

class DatabaseService {
  static final DatabaseService databaseService = DatabaseService._internal();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  factory DatabaseService({required String uid}) {
    return databaseService;
  }

  DatabaseService._internal();

  // Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('product').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

//STREAMS HERE TO SORT SEARCH RESULTS BY TITLE , PRICE AND MANUFACTURER ASCENDING AND DESCENDING

  Stream<List<Product>> getAllProductsByTitleAsc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllProductsByTitleDesc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllProductsByManufacturerDesc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('manufacturer', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllProductsByManufacturerAsc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('manufacturer')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllProductsByPriceAsc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('price')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllProductsByPriceDesc() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('price', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllWishlist() {
    return _firebaseFirestore
        .collection('wishlist')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getAllFootwear() {
    return _firebaseFirestore
        .collection('product')
        .where('category', isEqualTo: 'footwear')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

//For Custom Products Category
  Stream<List<Product>> getAllByCategory() {
    return _firebaseFirestore
        .collection('product')
        .where('category', isEqualTo: 'custom')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  //collection reference
  final CollectionReference userDataCollection = FirebaseFirestore.instance
      .collection('UserData'); //Firestore will create this collection for us

  Future updateUserData(
      String uid,
      String? email,
      String firstName,
      String secondName,
      String cardNum,
      String cvv,
      String expiryDate,
      String address,
      String city,
      String zipCode,
      String country,
      String studentID) async {
    return await userDataCollection.doc(uid).set(({
          'uid': uid,
          'email': email,
          'firstName': firstName,
          'secondName': secondName,
          'cardNum': cardNum,
          'cvv': cvv,
          'expiryDate': expiryDate,
          'address': address,
          'city': city,
          'zipCode': zipCode,
          'country': country,
          'studentID': studentID,
        }));
  }








  Stream<List<UserInformation>> getAllUsers() {
    return _firebaseFirestore.collection('UserData').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserInformation.fromSnapshot(doc)).toList();
    });
  }



 
  

 
  



 
  }





