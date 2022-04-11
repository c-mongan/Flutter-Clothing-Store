import '../product.dart';
import '../product_decorator.dart';

class CustomLogo extends ProductDecorator {
  CustomLogo(CustomProduct product) : super(product) {
    description = 'Custom Logo';
  }

  @override
  String getDescription() {
    return '${product.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return product.getPrice() + 10.0;
  }
}
