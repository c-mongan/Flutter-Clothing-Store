import 'package:meta/meta.dart';

abstract class CustomProduct {
  @protected
  late String description;

  String getDescription();
  double getPrice();
}
