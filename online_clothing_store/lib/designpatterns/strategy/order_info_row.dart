import 'package:flutter/material.dart';
export 'order_info_row.dart';

class OrderInformationRow extends StatelessWidget {
  final String label;
  final double value;
  final String fontFamily;

  OrderInformationRow({
    required this.label,
    required this.value,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontFamily: fontFamily, color: Colors.white)),
        Text('\€${value.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontFamily: fontFamily, color: Colors.white)),
      ],
    );
  }
}
