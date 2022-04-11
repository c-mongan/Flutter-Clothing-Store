import 'package:flutter/material.dart';
import 'package:health_app_fyp/designpatterns/decorator/decorator/decorator.dart';

import '../../../constants/constants.dart';

class ProductInformation extends StatelessWidget {
  final CustomProduct product;

  const ProductInformation({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Product details:',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: LayoutConstants.spaceL),
        Text(
          product.getDescription(),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: LayoutConstants.spaceM),
        Text('Price: \€${product.getPrice().toStringAsFixed(2)}'),
      ],
    );
  }
}
