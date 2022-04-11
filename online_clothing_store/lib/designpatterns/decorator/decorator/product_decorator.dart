import 'product.dart';

abstract class ProductDecorator extends CustomProduct {
  final CustomProduct product;

  ProductDecorator(this.product);

  @override
  String getDescription() {
    return product.getDescription();
  }

  @override
  double getPrice() {
    return product.getPrice();
  }
}
