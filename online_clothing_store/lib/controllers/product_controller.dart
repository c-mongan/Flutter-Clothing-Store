
import 'package:get/get.dart';

import '../model/product.dart';
import '../services/database.dart';

class ProductController extends GetxController {
 //List of product objects
  final products = <Product>[].obs;

//Connects our products list to the database
  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}



// Stream <List<Video>> lista() {
//   Stream <QuerySnapshot> stream =
//     Firestore.instance.collection('videos').snapshots();

//   return stream.map((qShot) => qShot.documents
//     .map((doc) => Video(
//       title: doc.data['title'],
//       url: doc.data['url'],
//       datum: doc.data['datum']))
//     .toList());
// }


  // static Product fromSnapshot(DocumentSnapshot snap) {
  //   Product product = Product(
  //     name: snap['name'],
  //     price: snap['price'],
  //     imageUrl: snap['imageUrl'],
  //   );
  //   return product;
  // }


//   Stream<List<Product>> getAllProducts() {
//     return _firebaseFirestore
//         .collection('products')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
//     });
//   }
// }