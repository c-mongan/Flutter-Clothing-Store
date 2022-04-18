import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //include title, manufacturer, price, category

  // Product's variables: name, price, imageUrl. All .
 String? name;
  num? price;
   String? imageUrl;
   String? itemID;
  final String? category;
  final String? manufacturer;
  //  String? size;
  final String? description;
   String? color;
   String? color2;
   num? stock;

  Product(
      {
      //  this.uid,
       this.name,
       this.price,
       this.imageUrl,
       this.category,
       this.manufacturer,
       this.description,
       this.color,
       this.color2,
       this.stock,
       this.itemID});

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
      itemID: snap['itemID'],
    );
    return product;
  }

  //Get Data from the server
  factory Product.fromMap(map) {
    return Product(
      // uid: map['uid'],
      name: map['name'],
      category: map['category'],
      manufacturer: map['manufacturer'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      stock: map['stock'],
      description: map['description'],
      color: map['color'],
      color2: map['color2'],
      itemID: map['itemID'],
    );
  }
  //Send data to our server

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'manufacturer': manufacturer,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'description': description,
      'color': color,
      'color2': color2,
      'itemID': itemID,
    };
  }
}
