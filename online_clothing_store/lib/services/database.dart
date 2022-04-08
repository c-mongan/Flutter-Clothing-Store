import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class DatabaseService {
  static final DatabaseService databaseService = DatabaseService._internal();

  factory DatabaseService() {
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
