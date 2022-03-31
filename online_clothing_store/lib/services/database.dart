import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('product').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  //  Stream<List<OrderItem>> getAllOrders() {
  //   return _firebaseFirestore.collection('OrderItem').snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) => OrderItem.fromSnapshot(doc)).toList();
  //   });
  // }

  Stream<List<Product>> getAllFootwear() {
    return _firebaseFirestore
        .collection('product')
        .where('category', isEqualTo: 'footwear')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
