import 'package:flutter/material.dart';

import '../../../../../constants/constants.dart';
import '../../../delivery_interface.dart';
import '../../../order/order.dart';
import 'order_info_row.dart';

class OrderDetails extends StatelessWidget {
  final Order order;
  final InterfaceDeliveryCostsStrategy shippingCostStrategy;

  // ignore: use_key_in_widget_constructors
  const OrderDetails({
    required this.order,
    required this.shippingCostStrategy,
  });

  double get deliveryCost => shippingCostStrategy.calculate(order);
  double get total => order.price + deliveryCost;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Details',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            OrderInformationRow(
              fontFamily: 'Montserrat',
              label: 'Subtotal',
              value: order.price,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            OrderInformationRow(
              fontFamily: 'Roboto',
              label: 'Delivery',
              value: deliveryCost,
            ),
            const Divider(),
            OrderInformationRow(
              fontFamily: 'RobotoMedium',
              label: 'Order total',
              value: total,
            ),
          ],
        ),
      ),
    );
  }
}
