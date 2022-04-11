import '../product.dart';
import '../product_decorator.dart';

class ExtraLogo extends ProductDecorator {
  ExtraLogo(CustomProduct product) : super(product) {
    description = 'Extra Logo';
  }

  @override
  String getDescription() {
    return '${product.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return product.getPrice() + 5.0;
  }
}
