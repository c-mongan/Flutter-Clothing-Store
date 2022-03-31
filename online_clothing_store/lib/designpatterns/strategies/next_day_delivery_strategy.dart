import '../delivery_interface.dart';
import '../order/order.dart';

class PriorityDeliveryStrategy implements InterfaceDeliveryCostsStrategy {
  @override
  String label = 'Express next day delivery';

  @override
  double calculate(Order order) {
    return 15.00;
  }
}
