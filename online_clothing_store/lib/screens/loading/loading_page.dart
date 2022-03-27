import 'dart:async';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => LoadingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => Navigator.pushNamed(context, '/'));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              width: 125,
              height: 125,
            ),
          ),
          SizedBox(height: 30),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              'E-Commerce Store',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
