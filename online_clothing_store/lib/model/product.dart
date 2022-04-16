import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //include title, manufacturer, price, category

  // Product's variables: name, price, imageUrl. All required.
  late final String name;
  num price;
  late final String imageUrl;
 late final String itemID;
  final String category;
  final String manufacturer;
  // late final String size;
  final String description;
  late final String color;
  late final String color2;
  late final num stock;

  Product(
      {
      // required this.uid,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.category,
      required this.manufacturer,
      required this.description,
      required this.color,
      required this.color2,
      required this.stock,
      required this.itemID
      });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      // uid: snap['uid'],
      name: snap['name'],
      category: snap['category'],
      manufacturer: snap['manufacturer'],
      price: snap['price'],
      imageUrl: snap['imageUrl'],
      stock: snap['stock'],
      description: snap['description'],
      color: snap['color'],
      color2: snap['color2'],
      itemID : snap['itemID'],
      
    );
    return product;
  }
}
