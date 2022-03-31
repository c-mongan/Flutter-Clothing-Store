import '../delivery_interface.dart';
import '../order/order.dart';

class InStoreCollectionStrategy implements InterfaceDeliveryCostsStrategy {
  @override
  String label = 'In-store collection';

  @override
  double calculate(Order order) {
    return 0.0;
  }
}
