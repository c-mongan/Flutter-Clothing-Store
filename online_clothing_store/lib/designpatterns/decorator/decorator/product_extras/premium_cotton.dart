import '../product.dart';
import '../product_decorator.dart';

class PremiumCotton extends ProductDecorator {
  PremiumCotton(CustomProduct product) : super(product) {
    description = 'Premium Cotton';
  }

  @override
  String getDescription() {
    return '${product.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return product.getPrice() + 20.0;
  }
}
