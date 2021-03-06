import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/designpatterns/decorator/widgets/decorator_class.dart';
import 'package:health_app_fyp/screens/screens.dart';
import 'package:health_app_fyp/widgets/custom_products.dart';

import '../screens/inventory/producttype/custom_item.dart';
import '../screens/inventory/producttype/lowerwear.dart';
import '../screens/inventory/producttype/upperwear.dart';

class ProductsCarousel extends StatefulWidget {
  ProductsCarousel({Key? key}) : super(key: key);

  @override
  _ProductsCarouselState createState() => _ProductsCarouselState();
}

List<Widget> cards = [
  InnerNeumorphicCardFb1(
      text: "Upper Wear",
      subtitle: "T-shirts,Jackets & Shirts",
      onPressed: () {
        Get.to(UpperwearPage());
      }),
  InnerNeumorphicCardFb1(
      text: "Bottoms",
      subtitle: "Jeans, Trousers & Shorts",
      onPressed: () {
        Get.to(const LowerwearPage());
      }),
  InnerNeumorphicCardFb1(
      text: "Custom Range",
      subtitle: "Browse our customisable products",
      onPressed: () {
        Get.to(const CustomItemPage());
      }),
];

class _ProductsCarouselState extends State<ProductsCarousel> {
  final double carouselItemMargin = 16;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: .7);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: cards.length,
        onPageChanged: (int position) {
          setState(() {});
        },
        itemBuilder: (BuildContext context, int position) {
          return imageSlider(position, context);
        });
  }

  Widget imageSlider(int position, BuildContext context) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return Container(
          margin: EdgeInsets.all(carouselItemMargin),
          child: Center(child: widget),
        );
      },
      child: Container(
        child: cards[position],
      ),
    );
  }
}

class NeumorphicCard extends StatefulWidget {
  final String text;

  final String subTitle;

  final double bevel;
  final Offset blurOffset;
  final Color color;
  final EdgeInsets padding;

  NeumorphicCard({
    Key? key,
    this.bevel = 10.0,
    this.padding = const EdgeInsets.all(12.5),
    this.text = "Example",
    this.subTitle = "Subtitle",
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        color = Colors.grey.shade200,
        super(key: key);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  final bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return Listener(
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.bevel * 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _isPressed ? color : color.mix(Colors.white, .1),
                  _isPressed ? color.mix(Colors.white, .05) : color,
                  _isPressed ? color.mix(Colors.white, .05) : color,
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
                      color: color.mix(Colors.white, .3),
                    )
                  ],
          ),
          child: Container(
              child: InnerNeumorphicCardFb1(
                  text: widget.text,
                  subtitle: widget.subTitle,
                  onPressed: () {}))),
    );
  }
}

class InnerNeumorphicCardFb1 extends StatelessWidget {
  final String text;

  final String subtitle;
  final Function() onPressed;

  const InnerNeumorphicCardFb1(
      {required this.text,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 175,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
