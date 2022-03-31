import '../delivery_interface.dart';
import '../order/order.dart';
import '../order/order_products.dart';


class ParcelMotelStrategy implements InterfaceDeliveryCostsStrategy {
  @override
  String label = 'Parcel Motel pick up';

  @override
  double calculate(Order order) {
    return order.items.fold<double>(
      0.0,
      (sum, item) => sum + getOrderItemDeliveryPrice(item),
    );
  }

  double getOrderItemDeliveryPrice(OrderProducts orderItem) {
    return 5.99;
  }
}
