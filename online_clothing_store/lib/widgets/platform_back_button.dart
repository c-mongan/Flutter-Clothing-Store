import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/home/home_page.dart';



class PlatformBackButton extends StatelessWidget {
  final Color color;

  const PlatformBackButton({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final icon = kIsWeb || Platform.isAndroid
        ? Icons.arrow_back
        : Icons.arrow_back_ios_new;

    return IconButton(
      icon: Icon(icon),
      color: color,
      splashRadius: 20.0,
      onPressed: () {
        Get.to(HomePage());
      },
    );
  }
}
