import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../decorator/product_extras_data.dart';

class CustomProductSelection extends StatelessWidget {
  final Map<int, ProductExtrasData> productExtrasDataMap;
  final Function(int, bool?) onSelected;

  const CustomProductSelection({
    required this.productExtrasDataMap,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: LayoutConstants.spaceM,
      children: <Widget>[
        for (var i = 0; i < productExtrasDataMap.length; i++)
          i == 0
              ? ChoiceChip(
                  label: const Text(
                    'Base Product',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: true,
                  selectedColor: Colors.grey,
                  onSelected: (_) {},
                )
              : ChoiceChip(
                  label: Text(
                    productExtrasDataMap[i]!.label,
                    style: TextStyle(
                      color: productExtrasDataMap[i]!.selected
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  selected: productExtrasDataMap[i]!.selected,
                  selectedColor: Colors.grey,
                  onSelected: (bool? selected) => onSelected(i, selected),
                ),
      ],
    );
  }
}
