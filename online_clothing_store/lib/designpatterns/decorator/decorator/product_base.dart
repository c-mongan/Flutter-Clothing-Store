import 'product.dart';

class ProductBase extends CustomProduct {
  ProductBase(String description) {
    this.description = description;
  }

  @override
  String getDescription() {
    return description;
  }

  @override
  double getPrice() {
    return 30.0;
  }
}
