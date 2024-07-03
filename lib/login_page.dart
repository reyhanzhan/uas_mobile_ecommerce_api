// import 'package:flutter/material.dart';
// import 'product_page.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _login(BuildContext context) async {
//     // Implementasi validasi login
//     String? customerId = await _getDeviceId(); // Ganti dengan metode login yang sesuai

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => ProductPage(customerId)),
//     );
//   }

//   Future<String?> _getDeviceId() async {
//     // Implementasi mendapatkan ID perangkat, contoh menggunakan device_info
//     // Sesuaikan dengan implementasi yang Anda gunakan
//     return 'device_id_example'; // Ganti dengan implementasi sesuai perangkat Anda
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => _login(context),
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'product_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String? customerId = await _getDeviceId();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductPage(customerId)),
    );
  }

  Future<String?> _getDeviceId() async {
    // Implementasi mendapatkan ID perangkat, contoh menggunakan device_info
    // Sesuaikan dengan implementasi yang Anda gunakan
    return 'device_id_example'; // Ganti dengan implementasi sesuai perangkat Anda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

