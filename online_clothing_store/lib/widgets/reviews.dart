// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:health_app_fyp/screens/screens.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// import '../controllers/basket_controller.dart';
// import '../controllers/product_controller.dart';
// import '../screens/product/product_page.dart';
// import 'customised_navbar.dart';

// class Reviews extends StatelessWidget {
//   final productController = Get.put(ProductController());

//  Reviews({Key? key}) : super(key: key);

 
//   String uid = FirebaseAuth.instance.currentUser!.uid;

//   User? user = FirebaseAuth.instance.currentUser;

//   // void asyncMethod(bool isVisible) async {
//   //   checkDay();
//   //   // await getbmiScore();
//   //   // ....
//   // }

//   // void callThisMethod(bool isVisible) {
//   //   debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
//   // }

// //DISPLAYS ALL SCANNED FOODS FROM TODAY
//   final Stream<QuerySnapshot> moodStream = FirebaseFirestore.instance
//       .collection('MoodTracking')
//       .orderBy("DateTime", descending: false)
//       // Uncomment to show all moods for today

//       // .where('DateTime',
//       //     isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
//       //         DateTime.now().month, DateTime.now().day, 0, 0))
//       // .where('DateTime',
//       //     isLessThanOrEqualTo: DateTime(DateTime.now().year,
//       //         DateTime.now().month, DateTime.now().day, 23, 59, 59))
//       .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .snapshots();

//   DateTime dateTimeText = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return
//         // VisibilityDetector(
//         //     key: Key("WishlistPage"),
//         //     onVisibilityChanged: (VisibilityInfo info) {
//         //       bool isVisible = info.visibleFraction != 0;
//         //       // asyncMethod(isVisible);
//         //     },
//         //     child:
//         Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Colors.black,
//           Colors.grey,
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         // child: SafeArea(
//         // resizeToAvoidBottomInset: false,
//         // appBar: AppBar(
//         //   title: const Text("Mood Tracker"),
//         //   elevation: 0,
//         //   backgroundColor: Colors.black,
//         // ),
//         // bottomNavigationBar: CustomisedNavigationBar(),
//         child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Column(children: [
//               const SizedBox(
//                 width: 5,
//               ),
//               // const Icon(Icons.insert_emoticon,
//               //     color: Colors.white, size: 40),
//               Expanded(
//                   child: Container(
//                       height: 225.0,
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: reviewsStream,
//                         builder: (BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.hasError) {
//                             return const Text('Something went wrong');
//                           }

//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Text("Loading");
//                           }

//                           return ListView(
//                             //itemExtent: 75,
//                             shrinkWrap: true,
//                             physics: const ClampingScrollPhysics(),
//                             children: snapshot.data!.docs
//                                 .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return ListTile(
//                                 leading: Image.network(data['imageUrl']),
//                                 title: Text(
//                                   data['name'],
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 isThreeLine: true,
//                                 subtitle: Text(
//                                   data['description'],
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 trailing: const Icon(Icons.line_weight),
//                                 iconColor: Colors.white,
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ))),

//               // Button(
//               //     edges: const EdgeInsets.all(0.0),
//               //     color: Colors.blue,
//               //     text: const Text(
//               //       'Home',
//               //       style: textStyle2,
//               //       // TextStyle(fontWeight: FontWeight.bold),
//               //     ),
//               //     onTap: () {
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => const HomePage(),
//               //         ),
//               //       );
//               //     }

//               //     )
//             ]
//                 // Flexible(
//                 //     flex: 1,
//                 //     child:

//                 )),
//       ),
//       floatingActionButton: getFloatingActionButton(),
//     );
//   }
// }

// bool dialVisible = true;
// Widget getFloatingActionButton() {
//   return SpeedDial(
//     backgroundColor: Colors.black,
//     animatedIcon: AnimatedIcons.menu_close,
//     animatedIconTheme: const IconThemeData(size: 22.0),
//     visible: dialVisible,
//     curve: Curves.bounceIn,
//     children: [
//       SpeedDialChild(
//         child: const Icon(Icons.minimize_outlined, color: Colors.white),
//         backgroundColor: Colors.red,
//         onTap: () async {
//           removeLastWishlistItem();
//         },
//         label: 'Delete Last Entry',
//         labelStyle: const TextStyle(fontWeight: FontWeight.w500),
//         labelBackgroundColor: Colors.red,
//       ),
//     ],
//   );
// }

// Future<void> removeLastWishlistItem() async {
//   QuerySnapshot querySnap = await FirebaseFirestore.instance
//       .collection('wishlist')
//       .orderBy("dateTime")
//       .limitToLast(1)
//       .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .get();

//   if (querySnap.docs.isNotEmpty) {
//     QueryDocumentSnapshot doc = querySnap.docs[
//         0]; // Assumption: the query returns only one document, THE doc you are looking for.
//     DocumentReference docRef = doc.reference;
//     await docRef.delete();
//   } else {
//     print("No documents found");
//     Fluttertoast.showToast(
//         msg: "No documents found",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
// }
