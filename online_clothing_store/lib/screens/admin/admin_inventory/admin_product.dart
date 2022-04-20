import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:health_app_fyp/model/product.dart';

import 'package:health_app_fyp/widgets/customised_appbar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/colors.dart';
import '../../../constants/layout_constants.dart';
import '../../../constants/style.dart';
import '../../../controllers/basket_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../designpatterns/command/command_history.dart';
import '../../../widgets/customised_navbar.dart';

class AdminProductPage extends StatefulWidget {
  final Product product;
  AdminProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final basketController = Get.put(BasketController());

  User? user = FirebaseAuth.instance.currentUser;
  Product FirestoreProduct = Product();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("product")
        .doc(widget.product.itemID)
        .get()
        .then((value) {
      FirestoreProduct = Product.fromMap(value.data());
    });

    setState(() {});
  }

  void asyncMethod(bool isVisible) async {
    FirebaseFirestore.instance
        .collection("product")
        .doc(widget.product.itemID)
        .get()
        .then((value) {
      FirestoreProduct = Product.fromMap(value.data());
      if (mounted) {
        setState(() {});
      }
    });
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  final ProductController productController = Get.find();

  final priceEditingController = TextEditingController();

  final stockEditingController = TextEditingController();

  final CommandHistory _commandHistory = CommandHistory();
  bool firstIsSelected = true;
  bool secondIsSelected = false;
  bool thirdIsSelected = false;
  bool fourthIsSelected = false;
  bool fifthIsSelected = false;
  bool isSubmitted = false;

  bool showCustomisation = false;
  bool showDetails = true;
  bool showReviews = false;

  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('reviews')
      .orderBy("date")
      .where('name', isEqualTo: widget.product.name)
      .snapshots();
  late int index = productController.products.indexOf(widget.product);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return VisibilityDetector(
        key: Key("key"),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          asyncMethod(isVisible);
        },
        child: Scaffold(
            appBar: CustomisedAppBar(title: widget.product.name!),
            bottomNavigationBar: const CustomisedNavigationBar(),
            body: Stack(children: [
              Positioned(
                top: 0,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: size.height - 430,
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.product.imageUrl!),
                      )),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                      height: size.height / 2.2,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.grey,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      height: 5,
                                      width: 32 * 1.5,
                                      decoration: BoxDecoration(
                                        gradient: AppColor.gradient,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                  ProductNameAndPrice(product: widget.product),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.product.manufacturer!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  const SizedBox(
                                      height: LayoutConstants.spaceM),
                                  Divider(color: Colors.white, height: 3),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(height: LayoutConstants.spaceM),
                                      const Spacing(),
                                      Row(
                                        children: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                if (showDetails == false) {
                                                  setState(() {
                                                    showDetails = true;
                                                    showCustomisation = false;
                                                    showReviews = false;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Details',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )),
                                          SizedBox(width: 8),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                if (showReviews == false) {
                                                  setState(() {
                                                    showReviews = true;
                                                    showCustomisation = false;
                                                    showDetails = false;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Reviews',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )),
                                          SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (showDetails == true) ...[
                                    TextBox(
                                      inputController: priceEditingController,
                                      text: "${FirestoreProduct.price}",
                                      label: 'Price',
                                    ),
                                    TextBox(
                                      label: 'Stock',
                                      inputController: stockEditingController,
                                      text: "${FirestoreProduct.stock}",
                                    ),
                                    // PriceInput(),
                                    // StockInput(),
                                    SizedBox(height: 30),
                                    Center(
                                      child: NeumorphicButton(
                                        child: Text(
                                          'Update Product',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => FirebaseFirestore
                                            .instance
                                            .collection('product')
                                            .doc(widget.product.itemID)
                                            .update({
                                          'price': double.parse(
                                              priceEditingController.text),
                                          'stock': double.parse(
                                              stockEditingController.text),
                                        }),
                                      ),
                                    )
                                  ],
                                  if (showReviews == true) ...[
                                    SizedBox(height: 10),
                                    Text(
                                      "Reviews",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                 
                                    Container(
                                        height: 225.0,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: reviewsStream,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              return const Text(
                                                  'No reviews Availiable');
                                            }

                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Text("Loading");
                                            }

                                            return ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              children: snapshot.data!.docs.map(
                                                  (DocumentSnapshot document) {
                                                Map<String, dynamic> data =
                                                    document.data()!
                                                        as Map<String, dynamic>;
                                                return ListTile(
                                                  title: Text(
                                                    data['usersName'] +
                                                        " " +
                                                        data['date'].toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  isThreeLine: true,
                                                  subtitle: Text(
                                                    data['review'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  trailing: const Icon(
                                                      Icons.line_weight),
                                                  iconColor: Colors.white,
                                                );
                                              }).toList(),
                                            );
                                          },
                                        )),
                                    SizedBox(height: 30),
                                    NeumorphicButton(
                                      child: Text(
                                        'Update Item',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () => FirebaseFirestore
                                          .instance
                                          .collection('product')
                                          .doc(widget.product.itemID)
                                          .update({
                                        'price': double.parse(
                                            priceEditingController.text),
                                        'stock': double.parse(
                                            stockEditingController.text),

                                        // basketController.addProduct(
                                        //     productController.products[index], index),
                                      }),
                                    ),
                                  ],
                                ]),
                          ))))
            ])));
  }
}

class TabTitle extends StatelessWidget {
  final String label;
  final bool selected;
  const TabTitle({
    Key? key,
    required this.label,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style: AppStyle.text.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          if (selected)
            Container(
              width: 21,
              height: 2,
              decoration: const BoxDecoration(color: AppColor.primary),
            )
        ])
      ],
    );
  }
}

class Spacing extends StatelessWidget {
  const Spacing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}

class RectButtonSelected extends StatelessWidget {
  final String label;
  const RectButtonSelected({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), gradient: AppColor.gradient),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text,
      )),
    );
  }
}

class RectButton extends StatelessWidget {
  final String label;
  const RectButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppColor.primary)),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text.copyWith(color: Colors.white),
      )),
    );
  }
}

class ProductNameAndPrice extends StatelessWidget {
  final Product product;
  const ProductNameAndPrice({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.name!,
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
        ),
        Text(
          " €" + product.price.toString(),
          style: AppStyle.h1Light.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final Color color;
  final bool selector;
  final bool submitted;
  final String text;

  const Button({
    this.color = Colors.blue,
    this.selector = false,
    this.submitted = false,
    this.text = '',
    onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: submitted
          ? selector
              ? 1
              : 0
          : 1,
      child: AnimatedContainer(
        margin: EdgeInsets.all(10),
        duration: Duration(milliseconds: 300),
        color: color,
        width: selector ? 30 : 20,
        height: selector ? 30 : 20,
        child: Center(
          child: Text(
            text,
            style: AppStyle.h3.copyWith(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;
  final EdgeInsets padding;
  final Function() onPressed;

  NeumorphicButton({
    Key? key,
    required this.child,
    this.bevel = 10.0,
    this.padding = const EdgeInsets.all(12.5),
    required this.onPressed,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        color = Colors.black,
        super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    widget.onPressed();
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: widget.padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isPressed ? color : color.mix(Colors.black, .1),
                _isPressed ? color.mix(Colors.black, .05) : color,
                _isPressed ? color.mix(Colors.black, .05) : color,
                color.mix(Colors.white, _isPressed ? .2 : .5),
              ],
              stops: const [
                0.0,
                .3,
                .6,
                1.0,
              ]),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: -widget.blurOffset,
                    color: color.mix(Colors.white, .6),
                  ),
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: widget.blurOffset,
                    color: color.mix(Colors.black, .3),
                  )
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount)!;
  }
}

class PriceInput extends StatelessWidget {
  const PriceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(.9)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              onChanged: (value) {},
              style: const TextStyle(fontSize: 14, color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff161C22),
                hintText: 'Update Price',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StockInput extends StatelessWidget {
  const StockInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stock",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(.9)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              obscureText: true,
              onChanged: (value) {},
              style: const TextStyle(fontSize: 14, color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff161C22),
                hintText: '',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmStockInput extends StatelessWidget {
  const ConfirmStockInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirm Stock",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withOpacity(.9)),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              obscureText: true,
              onChanged: (value) {},
              style: const TextStyle(fontSize: 14, color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff161C22),
                hintText: 'Enter your stock',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController inputController;
  String text;
  String label;
  TextBox(
      {Key? key,
      required this.inputController,
      required this.text,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.grey;
    const secondaryColor = Colors.black;
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(.9)),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: TextField(
            controller: inputController,
            onChanged: (value) {
              value = inputController.text;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              //label: Text(text),
              labelStyle: const TextStyle(color: Colors.black),
              filled: true,
              fillColor: accentColor,
              hintText: text,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RatingWidget extends StatefulWidget {
  RatingWidget({Key? key}) : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late List<bool> rating;
  @override
  void initState() {
    super.initState();
    rating = [false, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingStar(
            selected: rating[0],
            onPressed: () {
              setState(() {
                rating[0] = true;
                if (rating[0]) {
                  rating[1] = false;
                  rating[2] = false;
                  rating[3] = false;
                  rating[4] = false;
                }
              });
            }),
        RatingStar(
            selected: rating[1],
            onPressed: () {
              setState(() {
                rating[0] = true;
                rating[1] = true;
                if (rating[1]) {
                  rating[2] = false;
                  rating[3] = false;
                  rating[4] = false;
                }
              });
            }),
        RatingStar(
            selected: rating[2],
            onPressed: () {
              setState(() {
                rating[0] = true;
                rating[1] = true;
                rating[2] = true;
                if (rating[2]) {
                  rating[3] = false;
                  rating[4] = false;
                }
              });
            }),
        RatingStar(
            selected: rating[3],
            onPressed: () {
              setState(() {
                rating[0] = true;
                rating[1] = true;
                rating[2] = true;
                rating[3] = true;
                if (rating[3]) {
                  rating[4] = false;
                }
              });
            }),
        RatingStar(
            selected: rating[4],
            onPressed: () {
              setState(() {
                rating[0] = true;
                rating[1] = true;
                rating[2] = true;
                rating[3] = true;
                rating[4] = true;
              });
            }),
      ],
    );
  }
}

class RatingStar extends StatelessWidget {
  final bool selected;
  final Function() onPressed;

  RatingStar({required this.selected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.network(selected
          ? "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Star%20(1).png?alt=media&token=8fcd6d83-829c-4f1a-b4c4-780e44ee0a04"
          : "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Star.png?alt=media&token=60006252-d156-45d0-9ce4-aad6ceee7429"),
    );
  }
}
