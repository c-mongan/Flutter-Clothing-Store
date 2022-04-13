import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:health_app_fyp/screens/checkout/checkout_page.dart';
import 'package:openfoodfacts/model/parameter/SortBy.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/carosel_slider.dart';
import '../../widgets/customised_appbar.dart';
import '../../widgets/customised_navbar.dart';
import '../authentication/login_screen.dart';
import '../customised_products/customised_products.dart';
import '../product/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  String setFilterCriterea() {
    String filterCriterea = "";
    //setFilterBy(_TabBarAndTabViewsState2._tabController2.index);
    // setOrderBy(i);
    String setBy =
        setOrderBy(_TabBarAndTabViewsState2._tabController2.index).toString();
    String filterBy =
        setFilterBy(_TabBarAndTabViewsState._tabController.index).toString();
    // print(setBy + " RESULT");
    // print(filterBy + ' RESULT 2');

    if (setBy != "" && filterBy != "") {
      filterCriterea = filterBy + " " + setBy;
      print(filterCriterea);
      return filterCriterea;
    }

    filterCriterea = "Error";
    return filterCriterea;
  }

  final String hintText = "Search";

  bool asc = false;
  bool desc = false;
  String sortBy = "";

  Widget build(BuildContext context) => Scaffold(
      appBar: CustomisedAppBar(title: 'Products'),
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomisedNavigationBar(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black,
            Colors.grey,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
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
              const Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              SizedBox(height: 20),
              Container(
                height: 40,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(.1)),
                ]),
                child: TextField(
                  controller: searchController,
                  textAlign: TextAlign.center,

                  //When text is entered call the search products method and pass in the text (value)
                  onChanged: (value) =>
                      //searchProducts(value),

                      productController.searchProducts(
                          value, setFilterCriterea()),
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.search, size: 20, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
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
                height: 61,
                child: TabBarAndTabViews2(),
              ),
              SizedBox(
                height: 100,
                child: TabBarAndTabViews(),
              ),
              // Divider(
              //   color: Colors.grey,
              //   thickness: 3,
              // ),
              RaisedButton(
                  color: Colors.grey,
                  child: const Text('Sort Items',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onPressed: () {
                    setState(() {
                      //  setFilterCriterea();
                      productController.searchProducts(
                          " ", setFilterCriterea());
                    });
                  }),
              Divider(
                color: Colors.grey,
                thickness: 3,
              ),
              SizedBox(
                  height: 300,
                  child: Obx(
                    () => Flexible(
                      child: ListView.builder(
                          itemCount: productController.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InventoryProductCard(index: index);
                          }),
                    ),
                  )),
              logOutButton(context),
            ],
          )))));

  ActionChip logOutButton(BuildContext context) {
    return ActionChip(
        label: const Text("Log Out"),
        labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
        backgroundColor: Colors.red,
        onPressed: () {
          logout(context, controller);
        });
  }

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
            //If the item is in the custom items category, then navigate to the customised products page
            if (productController.products[index].category == 'custom') {
              Get.to(() => (CustomisedProductPage(
                  product: productController.products[index])));
            } else {
              //If the item is not in the custom items category, then navigate to the product page
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                    ' € ${productController.products[index].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
              ),

              //Removed Quick Add Button
              // IconButton(
              //   onPressed: () {
              //     //Adds product to cart
              //     basketController.addProduct(
              //         productController.products[index], index);
              //   },
              //   icon: const Icon(
              //     Icons.add_circle,
              //   ),
              // ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ],
          ),
        ));
  }
}

class TabPair {
  final Tab tab;
  final Widget view;
  final VoidCallback onTap;
  int selectedIndex;
  TabBarAndTabViews2 tab2 = new TabBarAndTabViews2();

  TabPair(
      {required this.tab,
      required this.view,
      required this.onTap,
      required this.selectedIndex});
}

List<TabPair> TabPairs = [
  TabPair(
    selectedIndex: 0,
    onTap: () {
      setFilterBy(0);
    },
    tab: Tab(
      text: 'Title',
    ),
    view: Center(
      child: Text(
        'Sort by : Title',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  ),
  TabPair(
    selectedIndex: 1,
    onTap: () {
      setFilterBy(1);
    },
    tab: Tab(
      text: 'Manufacturer',
    ),
    view: Center(
      // replace with your own widget here
      child: Text(
        'Sort by : Manufacturer',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  ),
  TabPair(
    selectedIndex: 2,
    onTap: () {
      setFilterBy(2);
    },
    tab: Tab(
      text: 'Price',
    ),
    view: Center(
      child: Text(
        'Sort by : Price',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  )
];

class TabBarAndTabViews extends StatefulWidget {
  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  static late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: TabPairs.length,
      vsync: this,
    );
    super.initState();

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      setFilterBy(_tabController.index);
      // print("Selected Index: " + _tabController.index.toString());
      //setFilterBy(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change height to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.grey,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: TabPairs.map((tabPair) => tabPair.tab).toList()),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: TabPairs.map((tabPair) => tabPair.view).toList()),
          ),
        ],
      ),
    );
  }
}

class TabPair2 {
  final Tab tab;
  final Widget view;
  VoidCallback onTap;
  int selectedIndex;
  TabPair2(
      {required this.tab,
      required this.view,
      required this.onTap,
      required this.selectedIndex});
}

List<TabPair2> TabPair2s = [
  TabPair2(
    selectedIndex: 0,
    onTap: () {
      setOrderBy(0);
    },
    tab: Tab(
      text: 'Ascending',
    ),
    view: Center(
      child: Text(
        'Asc',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  ),
  TabPair2(
    selectedIndex: 1,
    onTap: () {
      setOrderBy(1);
    },
    tab: Tab(
      text: 'Descending',
    ),
    view: Center(
      child: Text(
        'Desc',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  )
];

class TabBarAndTabViews2 extends StatefulWidget {
  @override
  _TabBarAndTabViewsState2 createState() => _TabBarAndTabViewsState2();
}

class _TabBarAndTabViewsState2 extends State<TabBarAndTabViews2>
    with SingleTickerProviderStateMixin {
  static late TabController _tabController2;
  int _selectedIndex2 = 0;

  @override
  void initState() {
    _tabController2 = TabController(length: TabPair2s.length, vsync: this);
    super.initState();

    _tabController2.addListener(() {
      setState(() {
        _selectedIndex2 = _tabController2.index;
      });
      setOrderBy(_tabController2.index);
      // print("Selected Index: " + _tabController.index.toString());
      //setFilterBy(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // give the tab bar a height [can change height to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TabBar(
                  controller: _tabController2,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.grey,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: TabPair2s.map((TabPair2) => TabPair2.tab).toList()),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController2,
                children: TabPair2s.map((TabPair2) => TabPair2.view).toList()),
          ),
        ],
      ),
    );
  }
}

String setOrderBy(int i) {
  String orderBy;
  if (i == 0) {
    orderBy = 'ascending';
    // print(orderBy);
    return orderBy;
  } else if (i == 1) {
    orderBy = 'descending';
    // print(orderBy);
    return orderBy;
  }
  return orderBy = "error";
}

String setFilterBy(int i) {
  String filterBy;
  if (i == 0) {
    filterBy = 'title';
    //print(filterBy);
    return filterBy;
  } else if (i == 1) {
    filterBy = 'manufacturer';
    // print(filterBy);
    return filterBy;
  } else if (i == 2) {
    filterBy = 'price';
    print(filterBy);
    return filterBy;
  }
  filterBy = "Error";
  print(filterBy);
  return filterBy;
}
