class ProductExtrasData {
  final String label;
  bool selected = false;

  ProductExtrasData(this.label);

  // ignore: use_setters_to_change_properties
  void setSelected({required bool isSelected}) {
    selected = isSelected;
  }
}
