import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/carosel_slider.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../../widgets/inventory_products.dart';
import '../authentication/login_screen.dart';



class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

//Route name
  static const String routeName = '/';

  //Route Method
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => HomePage());
  }

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();

  // @override
  // void initState() {

  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     loggedInUser = UserModel.fromMap(value.data());
  //       super.initState();

  //     setState(() {});

  //   });

  // void shoes(BuildContext context) {
  //   Navigator.pushNamed(context, '/shoes');
  //}
  // }

  final cartController = Get.put(BasketController());
  final productController = Get.put(ProductController());
  final BasketController controller = Get.find();
  late int index = index;

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustomisedAppBar(title: 'Products'),
      bottomNavigationBar: const CustomisedNavigationBar(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // colors: [Colors.red, Colors.white, Colors.red],
                  colors: [
                Colors.white,
                Colors.black,
                // Colors.red,
                //Colors.blue,

                // Colors.orange,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          // child: Expanded(
          child: SafeArea(
              child: SingleChildScrollView(
                  // <-- wrap this around
                  child: Column(
            children: <Widget>[
              // remaining stuffs
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(
                child: CustomCarouselFB2(),
                height: 250,
              ),

              Divider(
                color: Colors.white,
                thickness: 1,
              ),

              Text(
                "All Items",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(
                height: 300,
                child: InventoryProducts(),
              ),

              // CustomCarouselFB2(),

              // CatalogProducts(),

              // ElevatedButton(
              //     onPressed: () => Get.to(() => BasketPage()),
              //     child: const Text("Go to Cart")),

//Navigates to cateogry page
              // IconButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/shoes');
              //     //arguments: productController.products[index]);
              //   },
              //   icon: const Icon(
              //     Icons.four_g_plus_mobiledata_outlined,
              //   ),
              // ),

              ActionChip(
                  label: const Text("Log Out"),
                  labelStyle:
                      const TextStyle(color: Colors.white, fontSize: 15),
                  backgroundColor: Colors.red,
                  onPressed: () {
                    logout(context, controller);
                  }),
            ],
          ))))

      // )
      );

  // child: Center(
  //   child: Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         SizedBox(
  //           height: 55,
  //           child: Text(
  //             "Welcome !",
  //             // "Welcome ${loggedInUser.firstName} ${loggedInUser.secondName}!",
  //             style: const TextStyle(
  //                 fontSize: 25,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         const SizedBox(
  //           height: 120,
  //           // child: Image.asset("assets/healthy1.png",
  //           //     fit: BoxFit.contain)
  //         ),
  //         // ignore: prefer_const_constructors

  //         // ignore: prefer_const_constructors
  //         SizedBox(
  //           height: 25,
  //         ),
  //         Text("Your Name:",
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w500,
  //             )),
  //         Text("Your E-mail: ",
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w500,
  //             )),
  //         const SizedBox(
  //           height: 25,
  //         ),
  //         ActionChip(
  //             label: const Text("Log Out"),
  //             labelStyle:
  //                 const TextStyle(color: Colors.white, fontSize: 15),
  //             backgroundColor: Colors.red,
  //             onPressed: () {
  //               logout(context);
  //             }),
  //       ],
  //     ),
  //   ),
  // ),

// void removeProduct(Product product) {
//     if (_products.containsKey(product) && _products[product] == 1) {
//       _products.removeWhere((key, value) => key == product);
//     } else {
//       _products[product] -= 1;
//     }
//   }

// controller.removeProduct(product);

//Cart empties on logout
  Future<void> logout(BuildContext context, controller) async {
    if (isProducts(controller) == false) {


      //Clears list of products
      controller.products.clear();
      

      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      Fluttertoast.showToast(msg: "Logout Successful! ");
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      Fluttertoast.showToast(msg: "Logout Successful! ");
    }
    
  }

}

