import 'order_products.dart';

class Order {
  final List<OrderProducts> items = [];

  double get price =>
      items.fold(0.0, (sum, orderProduct) => sum + orderProduct.price);

  void addProductToOrder(OrderProducts orderProduct) {
    items.add(orderProduct);
  }
}
