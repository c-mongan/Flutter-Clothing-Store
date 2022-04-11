import 'package:flutter/material.dart';
import 'package:health_app_fyp/designpatterns/decorator/decorator/decorator.dart';
import 'package:health_app_fyp/designpatterns/decorator/widgets/product_information.dart';
import 'package:health_app_fyp/designpatterns/decorator/widgets/product_selection.dart';
import 'package:health_app_fyp/widgets/customised_appbar.dart';

import '../../../constants/constants.dart';
import 'custom_product_selection.dart';

class ProductDecorator extends StatefulWidget {
  const ProductDecorator();

  @override
  _ProductDecoratorState createState() => _ProductDecoratorState();
}

class _ProductDecoratorState extends State<ProductDecorator> {
  final ProductMenu productMenu = ProductMenu();

  late final Map<int, ProductExtrasData> _productExtrasDataMap;
  late CustomProduct _product;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _productExtrasDataMap = productMenu.getProductExtrasDataMap();
    _product = productMenu.getProduct(0, _productExtrasDataMap);
  }

  void _onSelectedIndexChanged(int? index) {
    _setSelectedIndex(index!);
    _setSelectedProduct(index);
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCustomProductChipSelected(int index, bool? selected) {
    _setChipSelected(index, selected!);
    _setSelectedProduct(_selectedIndex);
  }

  void _setChipSelected(int index, bool selected) {
    setState(() {
      _productExtrasDataMap[index]!.setSelected(isSelected: selected);
    });
  }

  void _setSelectedProduct(int index) {
    setState(() {
      _product = productMenu.getProduct(index, _productExtrasDataMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select your product:',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
            ProductSelection(
              selectedIndex: _selectedIndex,
              onChanged: _onSelectedIndexChanged,
            ),
            if (_selectedIndex == 2)
              CustomProductSelection(
                productExtrasDataMap: _productExtrasDataMap,
                onSelected: _onCustomProductChipSelected,
              ),
            ProductInformation(
              product: _product,
            ),
          ],
        ),
      ),
    ));
  }
}
