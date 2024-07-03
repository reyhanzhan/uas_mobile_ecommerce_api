// import 'package:flutter/material.dart';
// import 'package:uas_mobile/product_page.dart';
// import 'package:uas_mobile/cart_page.dart';
// import 'package:uas_mobile/profile_page.dart';
// import 'splash_screen.dart'; // Import splash screen

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SplashScreen(), // Ubah ke SplashScreen sebagai halaman pertama
//     routes: {
//       '/products': (context) => ProductPage(null), // Ganti 'device_id_example' dengan implementasi perangkat Anda
//       '/cart': (context) => CartPage(null), // Sesuaikan dengan pengiriman customerId
//       '/profile': (context) => ProfilePage(),
//     },
//   ));
// }

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
