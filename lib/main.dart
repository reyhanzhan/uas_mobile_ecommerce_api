import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_page.dart';
import 'splash_screen.dart';
import 'profile_page.dart';
import 'cart_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/products': (context) => ProductPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

