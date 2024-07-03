import 'package:flutter/material.dart';
import 'product_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
    });

    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }
}
