import '../strategy/delivery_interface.dart';
import 'order.dart';

class StandardDeliveryStrategy implements InterfaceDeliveryCostsStrategy {
  @override
  String label = 'Standard Delivery';

  @override
  double calculate(Order order) {
    return 7.50;
  }
}
