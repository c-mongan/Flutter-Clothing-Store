import 'order/order.dart';

abstract class InterfaceDeliveryCostsStrategy {
  late String label;
  double calculate(Order order);
}
