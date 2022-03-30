import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        color: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style:
              // Theme.of(context)
              //     .textTheme
              //     .headline3!
              //     .copyWith(color: Colors.white)
              const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  //  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold),
        ),
      ),

      iconTheme: const IconThemeData(color: Colors.grey),
      actions: [
        IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/wish');
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
