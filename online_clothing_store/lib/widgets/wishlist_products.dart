import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/screens.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/basket_controller.dart';
import '../controllers/product_controller.dart';
import '../screens/product/product_page.dart';
import 'customised_navbar.dart';

class WishlistProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  WishlistProducts({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> tdeeStream = FirebaseFirestore.instance
      .collection('wishlist')
      .orderBy("dateTime")
      //.limitToLast(1)
      .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  User? user = FirebaseAuth.instance.currentUser;

  // void asyncMethod(bool isVisible) async {
  //   checkDay();
  //   // await getbmiScore();
  //   // ....
  // }

  // void callThisMethod(bool isVisible) {
  //   debugPrint('_HomeScreenState.callThisMethod: isVisible: $isVisible');
  // }

//DISPLAYS ALL SCANNED FOODS FROM TODAY
  final Stream<QuerySnapshot> moodStream = FirebaseFirestore.instance
      .collection('MoodTracking')
      .orderBy("DateTime", descending: false)
      // Uncomment to show all moods for today

      // .where('DateTime',
      //     isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
      //         DateTime.now().month, DateTime.now().day, 0, 0))
      // .where('DateTime',
      //     isLessThanOrEqualTo: DateTime(DateTime.now().year,
      //         DateTime.now().month, DateTime.now().day, 23, 59, 59))
      .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  DateTime dateTimeText = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return
        // VisibilityDetector(
        //     key: Key("WishlistPage"),
        //     onVisibilityChanged: (VisibilityInfo info) {
        //       bool isVisible = info.visibleFraction != 0;
        //       // asyncMethod(isVisible);
        //     },
        //     child:
        Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text("Mood Tracker"),
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      // ),
      // bottomNavigationBar: CustomisedNavigationBar(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const SizedBox(
              width: 5,
            ),
            // const Icon(Icons.insert_emoticon,
            //     color: Colors.white, size: 40),
            Expanded(
                child: Container(
                    height: 400.0,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: tdeeStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }

                        return ListView(
                          //itemExtent: 75,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                                title: Text(data['name']),
                                isThreeLine: true,
                                subtitle: Text(data['description']),
                                trailing: const Icon(Icons.line_weight));
                          }).toList(),
                        );
                      },
                    ))),
            // Button(
            //     edges: const EdgeInsets.all(0.0),
            //     color: Colors.blue,
            //     text: const Text(
            //       'Home',
            //       style: textStyle2,
            //       // TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const HomePage(),
            //         ),
            //       );
            //     }

            //     )
          ]
              // Flexible(
              //     flex: 1,
              //     child:

              )),
    );
  }
}
