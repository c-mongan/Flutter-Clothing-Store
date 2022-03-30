import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app_fyp/model/product.dart';
import '../../constants/colors.dart';
import '../../constants/style.dart';
import '../../controllers/basket_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/customised_navbar.dart';

class ProductPage extends StatelessWidget {
  // static const String routeName = '/product';

  final Product product;
  final basketController = Get.put(BasketController());
  final ProductController productController = Get.find();

  ProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  // static Route route(product) {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (context) => ProductPage(product: product),
  //   );
  // }
  late int index = productController.products.indexOf(product);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const CustomisedNavigationBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height - 300,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.imageUrl),
                  )),
            ),
          ),
          // Positioned(
          //   top: 60,
          //   right: 20,
          //   child: Container(
          //     height: 32,
          //     width: 32,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(16),
          //         image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: NetworkImage(product.imageUrl),
          //         )),
          //   ),
          // ),
          // Positioned(
          //   top: 150,
          //   right: 24,
          //   child: Container(
          //     height: 276,
          //     width: 73,
          //     decoration: BoxDecoration(
          //         gradient: AppColor.gradient,
          //         borderRadius: BorderRadius.circular(20)),
          //     child: Column(children: [
          //       Container(
          //         margin: const EdgeInsets.only(top: 6),
          //         height: 61,
          //         width: 61,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image: DecorationImage(
          //               fit: BoxFit.cover,
          //               image: NetworkImage(product.imageUrl),
          //             )),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(top: 6),
          //         height: 61,
          //         width: 61,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image: DecorationImage(
          //               fit: BoxFit.cover,
          //               image: NetworkImage(product.imageUrl),
          //             )),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(top: 6),
          //         height: 61,
          //         width: 61,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image: DecorationImage(
          //               fit: BoxFit.cover,
          //               image: NetworkImage(product.imageUrl),
          //             )),
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(top: 6),
          //         height: 61,
          //         width: 61,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             image: DecorationImage(
          //               fit: BoxFit.cover,
          //               image: NetworkImage(product.imageUrl),
          //             )),
          //       ),
          //     ]),
          //   ),
          // ),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height / 2.2,
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
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
                      ProductNameAndPrice(product: product),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.manufacturer,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Text('Size',
                      //     style: AppStyle.text
                      //         .copyWith(color: Colors.white.withOpacity(.8))),
                      // const Spacing(),
                      // Row(
                      //   children: const [
                      //     RectButtonSelected(
                      //       label: 'S',
                      //     ),
                      //     RectButton(
                      //       label: 'M',
                      //     ),
                      //     RectButton(
                      //       label: 'L',
                      //     ),
                      //     RectButton(
                      //       label: 'XL',
                      //     ),
                      //   ],
                      // ),
                      const Spacing(),
                      Row(
                        children: const [
                          TabTitle(label: 'Details', selected: true),
                          SizedBox(width: 8),
                          TabTitle(label: 'Review', selected: false),
                        ],
                      ),
                      const Spacing(),
                      Text(
                        'This is weekdays design-your go-to for all the latest trends, no matter who you are.',
                        style: AppStyle.bodyText.copyWith(color: Colors.white),
                      ),
                      const Spacing(),
                      Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.primary),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(size.width / 1.4, 37))),
                              onPressed: () {
                                basketController.addProduct(
                                    productController.products[index]);
                              },
                              child: Text('Add To Cart',
                                  style: AppStyle.h3
                                      .copyWith(color: Colors.white))))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
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
          style: AppStyle.h1Light,
        ),
        Text(
          " €" + product.price.toString(),
          style: AppStyle.h1Light.copyWith(
              color: AppColor.primary,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
      ],
    );
  }
}
