import 'package:health_app_fyp/designpatterns/decorator/decorator/decorator.dart';



class ProductMenu {
  final Map<int, ProductExtrasData> _productExtrasDataMap = {
    1: ProductExtrasData('Tailored Fit'),
    2: ProductExtrasData('Custom Logo'),
    3: ProductExtrasData('Extra Custom Logo'),
    4: ProductExtrasData('Premium Cotton'),
    
  };

  Map<int, ProductExtrasData> getProductExtrasDataMap() => _productExtrasDataMap;

  CustomProduct getProduct(int index, Map<int, ProductExtrasData> productExtrasDataMap) {
    switch (index) {
      case 0:
        return _getFrontDesign();
      case 1:
        return _getBackDesign();
      case 2:
        return _getPremiumCustom(productExtrasDataMap);
    }

    throw Exception("Index of '$index' does not exist.");
  }

  CustomProduct _getFrontDesign() {
    CustomProduct product = ProductBase('Custom Front Design');
    product = CustomLogo(product);
    product = TailoredFit(product);
    

    return product;
  }

  CustomProduct _getBackDesign() {
    CustomProduct product = ProductBase('Custom Back Design');
    product = CustomLogo(product);
    product = TailoredFit(product);
    

    return product;
  }

  CustomProduct _getPremiumCustom(Map<int, ProductExtrasData> productExtrasDataMap) {
    CustomProduct product = ProductBase('Premium Custom');

    

    if (productExtrasDataMap[1]!.selected) {
      product = TailoredFit(product);
    }

if (productExtrasDataMap[2]!.selected) {
      product = CustomLogo(product);
    }

    if (productExtrasDataMap[3]!.selected) {
      product = ExtraLogo(product);
    }

    if (productExtrasDataMap[4]!.selected) {
      product = PremiumCotton(product);
    }

    
    

    return product;
  }
}
