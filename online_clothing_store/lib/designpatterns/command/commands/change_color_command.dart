import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../command.dart';
import '../item.dart';

class ChangeColorCommand implements Command {
  Item item;
  late String previousColor;

  ChangeColorCommand(
    this.item,
  ) {
    previousColor = item.color;
  }

  @override
  void execute() {
    if (item.color == "1") {
      item.color = "2";
    } else if (item.color == "2") {
      item.color = "1";
    }
  }

  @override
  String getTitle() {
    return 'Change color';
  }

  @override
  void undo() {
    item.color = previousColor;
  }
}
