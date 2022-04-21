import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:health_app_fyp/model/product.dart';
import 'package:health_app_fyp/widgets/customised_appbar.dart';
import '../../constants/colors.dart';
import '../../constants/layout_constants.dart';
import '../../constants/style.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../designpatterns/command/index.dart';
import '../../model/user_data.dart';
import '../../widgets/customised_navbar.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  // static const String routeName = '/product';

  final Product product;
  ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final basketController = Get.put(BasketController());
  var map = Map();
  User? user = FirebaseAuth.instance.currentUser;
  UserInformation loggedInUser = UserInformation();
  List<bool>? rating;
  final reviewController = TextEditingController();
  String content = "";

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    rating = [false, false, false, false, false];
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserInformation.fromMap(value.data());
    });
  }

  final ProductController productController = Get.find();

  final CommandHistory _commandHistory = CommandHistory();
  bool firstIsSelected = true;
  bool secondIsSelected = false;
  bool thirdIsSelected = false;
  bool fourthIsSelected = false;
  bool fifthIsSelected = false;
  bool isSubmitted = false;

  final Item _item = Item.initial();

  bool showCustomisation = false;
  bool showDetails = true;
  bool showReviews = false;

  late String color;
  late String initialColor;

  num getStars(rating) {
    int stars = 0;

    for (int i = 0; i < rating.length; i++) {
      if (rating[i]) {
        stars++;
      }
    }
    return stars;
  }

  Color displayColor(String color) {
    switch (color) {
      //add more color as your wish
      case "red":
        return Colors.red;
      case "blue":
        return Colors.blue;
      case "yellow":
        return Colors.yellow;
      case "orange":
        return Colors.orange;
      case "green":
        return Colors.green;
      case "black":
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }

  Color getColor(_item) {
    switch (_item.color) {
      //add more color as your wish
      case "1":
        return displayColor(widget.product.color!);
      case "2":
        return displayColor(widget.product.color2!);

      default:
        return Colors.transparent;
    }
  }

  void _changeColor() {
    // print(_item.color.toString() + " first ");
    final command = ChangeColorCommand(_item);
    _executeCommand(command);
    print(_commandHistory.commandHistoryList);
  }

  void _executeCommand(Command command) {
    setState(() {
      command.execute();
      _commandHistory.add(command);
      print(_commandHistory.commandHistoryList);
    });
  }

  void _changeSize() {
    final command = ChangeSizeCommand(_item);
    _executeCommand(command);
    selectSize(_item);
    print(_commandHistory.commandHistoryList);
  }

  void _undo() {
    setState(() {
      int i = _commandHistory.commandHistoryList.length;

      if (_commandHistory.commandHistoryList.isEmpty) {
        print("Empty");
        print(_commandHistory.commandHistoryList);
      } else if (_commandHistory.commandHistoryList[i - 1] == "Change color" &&
          i != -1) {
        _commandHistory.undo();

        print(_commandHistory.commandHistoryList);
      } else if (_commandHistory.commandHistoryList[i - 1] == "Change Size" &&
          i != -1) {
        undoSelectSize(_item);

        _commandHistory.undo();
        print(_commandHistory.commandHistoryList);
      }
    });
  }

  void undoSelectSize(_item) {
    switch (_item.size) {
      case "Medium":
        secondIsSelected = false;
        thirdIsSelected = false;
        firstIsSelected = !firstIsSelected;
        fourthIsSelected = false;
        break;
      case "Large":
        //  secondIsSelected = true;
        firstIsSelected = false;
        thirdIsSelected = false;
        secondIsSelected = !secondIsSelected;
        fourthIsSelected = false;
        break;
      case "Extra Large":
        // thirdIsSelected = true;
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = !thirdIsSelected;
        fourthIsSelected = false;
        break;
      case "Small":
        fourthIsSelected = true;
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = false;
        //fourthIsSelected = !fourthIsSelected;

        break;
      // case "Extra Extra Large":
      //   fifthIsSelected = true;
      //   break;
    }
  }

  void selectSize(_item) {
    switch (_item.size) {
      case "Small":
        secondIsSelected = false;
        thirdIsSelected = false;
        firstIsSelected = !firstIsSelected;
        fourthIsSelected = false;
        break;
      case "Medium":
        firstIsSelected = false;
        thirdIsSelected = false;
        secondIsSelected = !secondIsSelected;
        fourthIsSelected = false;
        break;
      case "Large":
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = !thirdIsSelected;
        fourthIsSelected = false;
        break;
      case "Extra Large":
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = false;
        fourthIsSelected = !fourthIsSelected;

        break;
    }
  }

  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('reviews')
      .orderBy("dateTime", descending: true)
      .where('name', isEqualTo: widget.product.name)
      .snapshots();
  late int index = productController.products.indexOf(widget.product);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.grey,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Colors.grey,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),

                    color: Colors.black,
                    //AppColor.secondary,
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
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    elevation: 0,
                                    onPressed: () {
                                      //FIRE BASE ADD TO FAVOURITES

                                      FirebaseFirestore.instance
                                          .collection('wishlist')
                                          .add({
                                        'userID': uid,
                                        'color1': widget.product.color,
                                        'color2': widget.product.color2,
                                        'category': widget.product.category,
                                        // 'size': widget.product.size,
                                        // 'productID': widget.product.uid,
                                        "dateTime": DateTime.now(),
                                        'description':
                                            widget.product.description,
                                        'price': widget.product.price,
                                        'manufacturer':
                                            widget.product.manufacturer,
                                        'name': widget.product.name,
                                        'imageUrl': widget.product.imageUrl,
                                      });

                                      Fluttertoast.showToast(
                                          msg: "Added to favourites",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 25),
                              const SizedBox(height: LayoutConstants.spaceM),
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
                                      // TabTitle(label: 'Review', selected: false),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            if (showCustomisation == false) {
                                              setState(() {
                                                showCustomisation = true;
                                                showDetails = false;
                                                showReviews = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            'Customise',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              if (showDetails == true) ...[
                                SizedBox(height: 30),
                                NeumorphicButton(
                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => basketController.addProduct(
                                      productController.products[index], index),
                                ),
                              ],
                              if (showReviews == true) ...[
                                SizedBox(height: 10),
                                Text(
                                  "Reviews",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingStar(
                                        selected: rating![0],
                                        onPressed: () {
                                          setState(() {
                                            rating![0] = true;
                                            if (rating![0]) {
                                              rating![1] = false;
                                              rating![2] = false;
                                              rating![3] = false;
                                              rating![4] = false;
                                            }
                                          });
                                        }),
                                    RatingStar(
                                        selected: rating![1],
                                        onPressed: () {
                                          setState(() {
                                            rating![0] = true;
                                            rating![1] = true;
                                            if (rating![1]) {
                                              rating![2] = false;
                                              rating![3] = false;
                                              rating![4] = false;
                                            }
                                          });
                                        }),
                                    RatingStar(
                                        selected: rating![2],
                                        onPressed: () {
                                          setState(() {
                                            rating![0] = true;
                                            rating![1] = true;
                                            rating![2] = true;
                                            if (rating![2]) {
                                              rating![3] = false;
                                              rating![4] = false;
                                            }
                                          });
                                        }),
                                    RatingStar(
                                        selected: rating![3],
                                        onPressed: () {
                                          setState(() {
                                            rating![0] = true;
                                            rating![1] = true;
                                            rating![2] = true;
                                            rating![3] = true;
                                            if (rating![3]) {
                                              rating![4] = false;
                                            }
                                          });
                                        }),
                                    RatingStar(
                                        selected: rating![4],
                                        onPressed: () {
                                          setState(() {
                                            rating![0] = true;
                                            rating![1] = true;
                                            rating![2] = true;
                                            rating![3] = true;
                                            rating![4] = true;
                                          });
                                        }),
                                  ],
                                ),

                                TextFormField(
                                  controller: reviewController,
                                  decoration: InputDecoration(
                                    labelText: 'Review',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                ),

                                // TextField(
                                //     maxLines: 5,
                                //     decoration: InputDecoration(
                                //         hintText: 'Write a review',
                                //         hintStyle:
                                //             TextStyle(color: Colors.white),
                                //         border: OutlineInputBorder()),
                                //     onChanged: (content) {
                                //       reviewController.text = content;
                                //     }),
                                SizedBox(height: 30),
                                NeumorphicButton(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () => FirebaseFirestore.instance
                                            .collection('reviews')
                                            .add({
                                          'usersName': loggedInUser.firstName! +
                                              ' ' +
                                              loggedInUser.secondName!,
                                          'userID': uid,
                                          'productID': widget.product.itemID,
                                          "dateTime": DateTime.now(),
                                          'review': reviewController.text,
                                          'name': widget.product.name,
                                          'rating': getStars(rating),
                                        })),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text("Reviews",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
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
                                              'Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading");
                                        }

                                        return Container(
                                          child: ListView(
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
                                                  data['usersName'].toString() +
                                                      " " +
                                                      (data['dateTime']
                                                              as Timestamp)
                                                          .toDate()
                                                          .toString()
                                                          .substring(0, 16),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                isThreeLine: true,
                                                subtitle: Text(
                                                  data['review'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: Wrap(
                                                  spacing:
                                                      12, // space between two icons
                                                  children: <Widget>[
                                                    Text(data['rating']
                                                        .toString()),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black26))),
                                        );
                                        ;
                                      },
                                    )),
                                SizedBox(height: 30),
                                NeumorphicButton(
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => basketController.addProduct(
                                      productController.products[index], index),
                                ),
                              ],
                              if (showCustomisation == true) ...[
                                Divider(color: Colors.white, height: 3),
                                SizedBox(height: 25),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(color: Colors.white, height: 3),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeColor();
                                        });
                                      },
                                      child: Button(
                                        selector: true,
                                        color: getColor(_item),
                                        submitted: isSubmitted,
                                        text: "",
                                      ),
                                    ),
                                    SizedBox(width: 35),
                                    NeumorphicButton(
                                        child: Text(
                                          'Change Color',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: _changeColor),
                                    SizedBox(width: 3),
                                  ],
                                ),
                                Divider(color: Colors.white, height: 3),
                                SizedBox(
                                  height: 35,
                                ),
                                Divider(color: Colors.white, height: 3),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                        });
                                      },
                                      child: Button(
                                        selector: firstIsSelected,
                                        color: Colors.black,
                                        submitted: isSubmitted,
                                        text: "S",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                        });
                                      },
                                      child: Button(
                                        selector: secondIsSelected,
                                        color: Colors.black,
                                        submitted: isSubmitted,
                                        text: "M",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                        });
                                      },
                                      child: Button(
                                        selector: thirdIsSelected,
                                        color: Colors.black,
                                        submitted: isSubmitted,
                                        text: "L",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                        });
                                      },
                                      child: Button(
                                        selector: fourthIsSelected,
                                        color: Colors.black,
                                        submitted: isSubmitted,
                                        text: "XL",
                                      ),
                                    ),
                                    SizedBox(width: 55),
                                    NeumorphicButton(
                                        child: Text(
                                          'Change Size',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: _changeSize),
                                  ],
                                ),
                                Divider(color: Colors.white, height: 3),
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  children: <Widget>[
                                    NeumorphicButton(
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () =>
                                          basketController.addProduct(
                                              productController.products[index],
                                              index),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    NeumorphicButton(
                                      child: Text(
                                        'Undo',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: _undo,
                                    ),
                                  ],
                                ),
                              ],
                            ]),
                      ))))
        ]));
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
          // style: AppStyle.h1Light,
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

class RatingWidget extends StatefulWidget {
  RatingWidget({Key? key, rating}) : super(key: key);

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
