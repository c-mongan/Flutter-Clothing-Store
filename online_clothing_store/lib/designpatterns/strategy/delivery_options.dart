import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import 'delivery_interface.dart';

// ignore: must_be_immutable
class DeliveryMethods extends StatelessWidget {
  List<InterfaceDeliveryCostsStrategy> deliveryOptions;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  DeliveryMethods({Key? key, 
    required this.deliveryOptions,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select delivery method:',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.white),
            ),
            for (var i = 0; i < deliveryOptions.length; i++)
              RadioListTile<int>(
                title: Text(deliveryOptions[i].label,
                    style: TextStyle(color: Colors.white)),
                value: i,
                groupValue: selectedIndex,
                onChanged: onChanged,
                dense: true,
                activeColor: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
