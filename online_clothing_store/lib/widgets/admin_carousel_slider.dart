import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/designpatterns/decorator/widgets/decorator_class.dart';
import 'package:health_app_fyp/screens/screens.dart';

import '../screens/admin/admin_add_product.dart';
import '../screens/inventory/producttype/custom_item.dart';
import '../screens/inventory/producttype/shoes.dart';

class AdminCarousel extends StatefulWidget {
  AdminCarousel({Key? key}) : super(key: key);

  @override
  _AdminCarouselState createState() => _AdminCarouselState();
}

List<Widget> cards = [
  InnerNeumorphicCardFb1(
      text: "Add product",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Designer_re_5v95%201.png?alt=media&token=5d053bd8-d0ea-4635-abb6-52d87539b7ec",
      subtitle: "+30 books",
      onPressed: () {
        Get.to(AdminAddProduct());
      }),
  InnerNeumorphicCardFb1(
      text: "Custom Products",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Accept_terms_re_lj38%201.png?alt=media&token=476b97fd-ba66-4f62-94a7-bce4be794f36",
      subtitle: "",
      onPressed: () {
        // Get.to(CustomisedProducts());
        Get.to(CustomItemPage());
      }),
  InnerNeumorphicCardFb1(
      text: "Remove Product",
      imageUrl:
          "https://p7.hiclipart.com/preview/967/334/474/nike-free-shoe-nike-air-max-running-jogging-shoes.jpg",
      // "https://img.freepik.com/free-photo/floating-shoe-gray-background-street-style-fashion_77190-6739.jpg",
      //"https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      // "https://media.gq.com/photos/60edfcd6bd0e74508541a513/master/w_2000,h_1333,c_limit/Nike-Pegasus-Trail-3-shoe.jpg",
      // "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      subtitle: "Browse all footwear",
      onPressed: () {
        Get.to(ShoesPage());
      }),
  InnerNeumorphicCardFb1(
      text: "Update Product",
      imageUrl:
          "https://p7.hiclipart.com/preview/967/334/474/nike-free-shoe-nike-air-max-running-jogging-shoes.jpg",
      // "https://img.freepik.com/free-photo/floating-shoe-gray-background-street-style-fashion_77190-6739.jpg",
      //"https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      // "https://media.gq.com/photos/60edfcd6bd0e74508541a513/master/w_2000,h_1333,c_limit/Nike-Pegasus-Trail-3-shoe.jpg",
      // "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      subtitle: "Browse all footwear",
      onPressed: () {
        Get.to(ShoesPage());
      }),
  InnerNeumorphicCardFb1(
      text: "View Customers",
      imageUrl:
          "https://p7.hiclipart.com/preview/967/334/474/nike-free-shoe-nike-air-max-running-jogging-shoes.jpg",
      // "https://img.freepik.com/free-photo/floating-shoe-gray-background-street-style-fashion_77190-6739.jpg",
      //"https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      // "https://media.gq.com/photos/60edfcd6bd0e74508541a513/master/w_2000,h_1333,c_limit/Nike-Pegasus-Trail-3-shoe.jpg",
      // "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
      subtitle: "Browse all footwear",
      onPressed: () {
        Get.to(ShoesPage());
      }),
];

class _AdminCarouselState extends State<AdminCarousel> {
  // - - - - - - - - - - - - Instructions - - - - - - - - - - - - - -
  // 1.Replace cards list with whatever widgets you'd like.
  // 2.Change the widgetMargin attribute, to ensure good spacing on all screensize.
  // 3.If you have a problem with this widget, please contact us at flutterbricks90@gmail.com
  // Learn to build this widget at https://www.youtube.com/watch?v=dSMw1Nb0QVg!
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  final double carouselItemMargin = 16;

  late PageController _pageController;
  int _position = 0;

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
          setState(() {
            _position = position;
          });
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

// class CardFb1 extends StatelessWidget {
//   final String text;
//   final String imageUrl;
//   final String subtitle;
//   final Function() onPressed;

//   const CardFb1(
//       {required this.text,
//       required this.imageUrl,
//       required this.subtitle,
//       required this.onPressed,
//       Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: 250,
//         height: 250,
//         padding: const EdgeInsets.all(30.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.5),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(10, 20),
//                 blurRadius: 10,
//                 spreadRadius: 0,
//                 color: Colors.grey.withOpacity(.05)),
//           ],
//         ),
//         child: Column(
//           children: [
//             Image.network(imageUrl, height: 90, fit: BoxFit.cover),
//             const Spacer(),
//             Text(text,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 )),
//             const SizedBox(
//               height: 5,
//             ),
//             Text(
//               subtitle,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 12),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NeumorphicCard extends StatefulWidget {
  final String text;
  final String imgUrl;
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
    this.imgUrl =
        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555",
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
                  imageUrl: widget.imgUrl,
                  subtitle: widget.subTitle,
                  onPressed: () {}))),
    );
  }
}

class InnerNeumorphicCardFb1 extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

  const InnerNeumorphicCardFb1(
      {required this.text,
      required this.imageUrl,
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
            Image.network(imageUrl, height: 70, fit: BoxFit.cover),
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
