import 'package:cloud_firestore/cloud_firestore.dart';

class Product {


  //include title, manufacturer, price, category

  // Product's variables: name, price, imageUrl. All required.
  final String name;
  final double price;
  final String imageUrl;
  final String uid;
  final String category;
  final String manufacturer;


  const Product( {
    required this.uid,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category, 
    required this.manufacturer,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      uid: snap['uid'],
      name: snap['name'],
       category: snap['category'],
       manufacturer: snap['manufacturer'],
      price: snap['price'],
      imageUrl: snap['imageUrl'],
    );
    return product;
  }

 
}
