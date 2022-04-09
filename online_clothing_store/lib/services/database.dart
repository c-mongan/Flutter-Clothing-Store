import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product.dart';

class DatabaseService {
  static final DatabaseService databaseService = DatabaseService._internal();
  //late String uid;
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
}
