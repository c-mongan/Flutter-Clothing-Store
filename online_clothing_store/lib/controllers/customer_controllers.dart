import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../model/user_data.dart';
import '../services/database.dart';

class UserController extends GetxController {
  //List of product objects
  late var users = <UserInformation>[].obs;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

//Connects our users list to the database
  @override
  void onInit() {
    //Stream of users from the database
    users.bindStream(DatabaseService(uid: user!.uid).getAllUsers());
    //Stream of users from the database by title (Ascending)

    super.onInit();
  }
}
