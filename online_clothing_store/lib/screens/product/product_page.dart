import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:health_app_fyp/model/product.dart';
import 'package:health_app_fyp/widgets/customised_appbar.dart';
import '../../constants/colors.dart';
import '../../constants/layout_constants.dart';
import '../../constants/style.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../designpatterns/command/command/command_history_column.dart';
import '../../designpatterns/command/command_history.dart';
import '../../designpatterns/command/index.dart';
import '../../widgets/customised_navbar.dart';
import '../../widgets/platform_button.dart';

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

  late String color;
  late String initialColor;

  _showCustomisation(showCustomisation) {
    if (showCustomisation == false) {
      setState(() {
        showCustomisation = false;
      });
    } else {
      setState(() {
        showCustomisation = true;
      });
    }
  }

  _showDetails(showDetails) {
    if (showDetails == false) {
      setState(() {
        showDetails = false;
      });
    } else {
      setState(() {
        showDetails = true;
      });
    }
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
        return displayColor(widget.product.color);
      case "2":
        return displayColor(widget.product.color2);

      default:
        return Colors.transparent;
    }
  }

  void _changeColor() {
    // print(_item.color.toString() + " first ");
    final command = ChangeColorCommand(_item);
    _executeCommand(command);
    print(_commandHistory.commandHistoryList);

    //  selectColor(_item);
    //  print(_item.color.toString() + " second ");
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
        // _item.color = initialColor;
        //  undoSelectColor(_item);

        _commandHistory.undo();

        print(_commandHistory.commandHistoryList);
      } else if (_commandHistory.commandHistoryList[i - 1] == "Change Size" &&
          i != -1) {
        undoSelectSize(_item);

        _commandHistory.undo();
        print(_commandHistory.commandHistoryList);
        // print(_item.size);
      }
      // for (int i = 0; i < _commandHistory.commandHistoryList.length; i++) {
      //   if (_commandHistory.commandHistoryList[i] == "Change Size") {
      //     undoSelectSize(_item);
      //     _commandHistory.undo();
      //   }
      // }
      // _commandHistory.undo();
    });
  }

  void undoSelectSize(_item) {
    switch (_item.size) {
      case "Medium":
        //firstIsSelected = true;
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
        //firstIsSelected = true;
        secondIsSelected = false;
        thirdIsSelected = false;
        firstIsSelected = !firstIsSelected;
        fourthIsSelected = false;
        break;
      case "Medium":
        //  secondIsSelected = true;
        firstIsSelected = false;
        thirdIsSelected = false;
        secondIsSelected = !secondIsSelected;
        fourthIsSelected = false;
        break;
      case "Large":
        // thirdIsSelected = true;
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = !thirdIsSelected;
        fourthIsSelected = false;
        break;
      case "Extra Large":
        // fourthIsSelected = true;
        firstIsSelected = false;
        secondIsSelected = false;
        thirdIsSelected = false;
        fourthIsSelected = !fourthIsSelected;

        break;
    }
  }

  late int index = productController.products.indexOf(widget.product);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomisedAppBar(title: widget.product.name),
        bottomNavigationBar: const CustomisedNavigationBar(),
        body: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height - 430,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.product.imageUrl),
                  )),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  height: size.height / 2.2,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //AppColor.secondary,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
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
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.product.manufacturer,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              const SizedBox(height: LayoutConstants.spaceM),
                              Divider(color: Colors.grey, height: 3),
                              Row(
                                children: <Widget>[
                                  SizedBox(height: LayoutConstants.spaceM),
                                  const Spacing(),
                                  Row(
                                    children: [
                                      // TabTitle(label: 'Details', selected: true

                                      // ),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          onPressed: () {
                                            if (showDetails == false) {
                                              setState(() {
                                                showDetails = true;
                                                showCustomisation = false;
                                              });
                                            }

                                            // else if (showDetails == true) {
                                            //   setState(
                                            //     () {
                                            //       showDetails = false;
                                            //       showCustomisation = false;
                                            //     },
                                            //   );
                                            // }
                                          },
                                          child: Text(
                                            'Details',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )),

                                      SizedBox(width: 8),

                                      TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          onPressed: null,
                                          child: Text(
                                            'Reviews',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )),
                                      SizedBox(width: 8),
                                      // TabTitle(label: 'Review', selected: false),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          onPressed: () {
                                            if (showCustomisation == false) {
                                              setState(() {
                                                showCustomisation = true;
                                                showDetails = false;
                                              });
                                              // } else if (showCustomisation ==
                                              //     true) {
                                              //   setState(
                                              //     () {
                                              //       showCustomisation = false;
                                              //       showDetails = true;
                                              //     },
                                              //   );
                                            }
                                          },
                                          child: Text(
                                            'Customise',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              if (showDetails == true) ...[
                                NeumorphicButton(
                                  child: Text('Add to Cart'),
                                  onPressed: () => basketController.addProduct(
                                      productController.products[index], index),
                                ),
                              ],
                              if (showCustomisation == true) ...[
                                Divider(color: Colors.grey, height: 3),
                                SizedBox(height: 25),
                                SizedBox(
                                  height: 5,
                                ),
                                // Divider(color: Colors.grey, height: 3),
                                // Text("Change Color"),
                                Divider(color: Colors.grey, height: 3),
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
                                    NeumorphicButton(
                                        child: Text('Change Color'),
                                        onPressed: _changeColor),
                                  ],
                                ),

                                Divider(color: Colors.grey, height: 3),
                                SizedBox(
                                  height: 35,
                                ),
                                // Divider(color: Colors.grey, height: 3),
                                // Text("Change Size"),
                                Divider(color: Colors.grey, height: 3),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                          // secondIsSelected = false;
                                          // thirdIsSelected = false;
                                          // firstIsSelected = !firstIsSelected;
                                          // fourthIsSelected = falsse;
                                          // _item.height = "Small";
                                          // // selectSize(_item);
                                        });
                                      },
                                      child: Button(
                                        selector: firstIsSelected,
                                        color: Colors.grey,
                                        submitted: isSubmitted,
                                        text: "S",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _changeSize();
                                          // firstIsSelected = false;
                                          // thirdIsSelected = false;
                                          // secondIsSelected = !secondIsSelected;
                                          // fourthIsSelected = false;
                                          // _item.height = "Medium";
                                        });
                                      },
                                      child: Button(
                                        selector: secondIsSelected,
                                        color: Colors.grey,
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
                                        color: Colors.grey,
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
                                        color: Colors.grey,
                                        submitted: isSubmitted,
                                        text: "XL",
                                      ),
                                    ),
                                    SizedBox(width: 65),
                                    NeumorphicButton(
                                        child: Text('Change Size'),
                                        onPressed: _changeSize),
                                  ],
                                ),

                                Divider(color: Colors.grey, height: 3),
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  children: <Widget>[
                                    NeumorphicButton(
                                      child: Text('Add to Cart'),
                                      onPressed: () =>
                                          basketController.addProduct(
                                              productController.products[index],
                                              index),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    NeumorphicButton(
                                      child: Text('Undo'),
                                      onPressed: _undo,
                                    ),
                                  ],
                                ),
                                // ] else if (showCustomisation = false) ...[
                                //   Divider(color: Colors.grey, height: 3),
                                //   SizedBox(height: 25),
                                //   SizedBox(
                                //     height: 5,
                                //   ),
                                //   // Divider(color: Colors.grey, height: 3),
                                //   // Text("Change Color"),
                                //   Divider(color: Colors.grey, height: 3),
                                //   Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         //   // Divider(color: Colors.grey, height: 3),
                                //         //   // SizedBox(
                                //         //   //   height: 35,
                                //         //   // ),
                                //         Row(
                                //           children: <Widget>[
                                //             NeumorphicButton(
                                //               child: const Text('Add to Cart'),
                                //               onPressed: () =>
                                //                   basketController.addProduct(
                                //                       productController
                                //                           .products[index],
                                //                       index),
                                //             ),
                                //           ],
                                //         )
                                //       ])
                                // ],
                              ]
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
          product.name,
          // style: AppStyle.h1Light,
          style: AppStyle.h1Light.copyWith(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 30),
        ),
        Text(
          " €" + product.price.toString(),
          style: AppStyle.h1Light.copyWith(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 20),
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
        color = Colors.grey.shade200,
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
