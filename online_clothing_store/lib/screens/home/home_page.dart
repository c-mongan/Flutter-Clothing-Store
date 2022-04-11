import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../model/models.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/carosel_slider.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../../widgets/inventory_products.dart';
import '../authentication/login_screen.dart';
import '../customised_products/customised_products.dart';
import '../product/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final cartController = Get.put(BasketController());
  final productController = Get.put(ProductController());
  final BasketController controller = Get.find();
  late int index = index;
  final searchController = TextEditingController();

  isProducts(controller) {
    if (controller.products.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  // void searchProducts(String query) {
  //   List suggestionList = productController.products.where((product) {
  //     final productTitle = product.name.toLowerCase();
  //     final input = query.toLowerCase();

  //     return productTitle.contains(input);
  //   }).toList();

  //   setState(() => suggestionList = productController.products);
  // }

  final String hintText = "Search";

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
                thickness: 3,
              ),
              SizedBox(
                child: CustomCarouselFB2(),
                height: 250,
              ),

              Divider(
                color: Colors.grey,
                thickness: 3,
              ),

              Text(
                "All Items",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              Divider(
                color: Colors.grey,
                thickness: 3,
              ),

              // SearchInputFb1(
              //     searchController: TextEditingController(),
              //     hintText: "Search Items"),]

              Container(
                height: 100,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(.1)),
                ]),
                child: TextField(
                  controller: searchController,
                  textAlign: TextAlign.center,
                  onChanged: (value) => productController.searchProducts(value)
                  // searchProducts(value);
                  ,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.email),
                    prefixIcon: const Icon(Icons.search,
                        size: 20, color: Color(0xffFF5A60)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 300,
                  // child: InventoryProducts(),

                  child: Obx(
                    () => Flexible(
                      child: ListView.builder(
                          itemCount: productController.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InventoryProductCard(index: index);
                          }),
                    ),
                  )),

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

class InventoryProductCard extends StatelessWidget {
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();
  final int index;

  InventoryProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (() {
            if (productController.products[index].category == 'custom') {
              Get.to(() => (CustomisedProductPage(
                  product: productController.products[index])));
            } else {
              Get.to(() =>
                  (ProductPage(product: productController.products[index])));
            }
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  productController.products[index].imageUrl,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  productController.products[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Text('€ ${productController.products[index].price}'),
              ),
              IconButton(
                onPressed: () {
                  //Adds product to cart
                  basketController.addProduct(
                      productController.products[index], index);
                },
                icon: const Icon(
                  Icons.add_circle,
                ),
              ),
            ],
          ),
        ));
  }
}
