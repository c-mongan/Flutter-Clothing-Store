import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../delivery_interface.dart';

class DeliveryMethods extends StatelessWidget {
  List<InterfaceDeliveryCostsStrategy> deliveryOptions;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  DeliveryMethods({
    required this.deliveryOptions,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select delivery method:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            for (var i = 0; i < deliveryOptions.length; i++)
              RadioListTile<int>(
                title: Text(deliveryOptions[i].label),
                value: i,
                groupValue: selectedIndex,
                onChanged: onChanged,
                dense: true,
                activeColor: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
