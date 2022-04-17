import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/screens.dart';

class CustomisedAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  //Passing title to constructor allows us to reuse the appbar throughoyt the app
  const CustomisedAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // This is all you need to centre titles
      backgroundColor: Colors.black,
      elevation: 0,
      title: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(WishlistPage());
          },
          icon: const Icon(Icons.favorite_outline_sharp),
        )
      ],
    );
  }

  @override
  //Determines height of appbar
  Size get preferredSize => const Size.fromHeight(50.0);
}
