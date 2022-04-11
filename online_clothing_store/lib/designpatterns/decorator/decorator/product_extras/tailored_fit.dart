import '../product.dart';
import '../product_decorator.dart';

class TailoredFit extends ProductDecorator {
  TailoredFit(CustomProduct product) : super(product) {
    description = 'Tailored Fit';
  }

  @override
  String getDescription() {
    return '${product.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return product.getPrice() + 5.5;
  }
}
