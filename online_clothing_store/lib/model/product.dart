import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //include title, manufacturer, price, category

  // Product's variables: name, price, imageUrl. All required.
  final String name;
   num price;
  final String imageUrl;
  final String uid;
  final String category;
  final String manufacturer;
  final String size;
  final String description;
  late final String color;
  late final String color2;

  Product({
    required this.uid,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.manufacturer,
    required this.size,
    required this.description,
    required this.color,
    required this.color2,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      uid: snap['uid'],
      name: snap['name'],
      category: snap['category'],
      manufacturer: snap['manufacturer'],
      price: snap['price'],
      imageUrl: snap['imageUrl'],
      size: snap['size'],
      description: snap['description'],
      color: snap['color'],
      color2: snap['color2'],
    );
    return product;
  }
}
