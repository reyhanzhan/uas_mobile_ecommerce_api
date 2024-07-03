// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:uas_mobile/cart_page.dart';
// import 'package:uas_mobile/profile_page.dart';

// class ProductPage extends StatefulWidget {
//   final String? customerId;

//   ProductPage(this.customerId);

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   late Future<List<dynamic>> _products;

//   @override
//   void initState() {
//     super.initState();
//     _products = _fetchProducts();
//   }

//   Future<List<dynamic>> _fetchProducts() async {
//     final response = await http.get(
//       Uri.parse('http://192.168.56.1:8000/api/products'),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   Future<void> _addToCart(int productId, String customerId) async {
//     final response = await http.post(
//       // Uri.parse('http://localhost/api/carts'),
//       Uri.parse('http://192.168.56.1:8000/api/products'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'product_id': productId,
//         'quantity': 1, // Ganti dengan jumlah yang dipilih
//         'customer_id': customerId,
//       }),
//     );

//     if (response.statusCode == 201) {
//       // Barang berhasil ditambahkan ke cart
//       print('Added to cart');
//     } else {
//       // Tangani error
//       print('Failed to add to cart');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Products')),
//       body: FutureBuilder<List<dynamic>>(
//         future: _products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<dynamic> products = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(products[index]['name']),
//                   subtitle: Text('\$${products[index]['price']}'),
//                   trailing: ElevatedButton(
//                     onPressed: () async {
//                       String? customerId = widget.customerId;
//                       _addToCart(
//                           products[index]['id'], customerId ?? 'unknown');
//                     },
//                     child: Text('Add to Cart'),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CartPage(widget.customerId)),
//           );
//         },
//         label: Text('Cart'),
//         icon: Icon(Icons.shopping_cart),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'cart_page.dart';
// import 'profile_page.dart';
// import 'login_page.dart';

// class ProductPage extends StatefulWidget {
//   final String? customerId;

//   ProductPage([this.customerId]);

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   late Future<List<dynamic>> _products;
//   String? _customerId;

//   @override
//   void initState() {
//     super.initState();
//     _products = _fetchProducts();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     String? customerId = widget.customerId ?? await _getDeviceId();
//     setState(() {
//       _customerId = customerId;
//     });
//   }

//   Future<String?> _getDeviceId() async {
//     return 'device_id_example';
//   }

//   Future<List<dynamic>> _fetchProducts() async {
//     final response = await http.get(
//       Uri.parse('http://192.168.56.1:8000/api/products'),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   Future<void> _addToCart(int productId, String customerId) async {
//     final response = await http.post(
//       Uri.parse('http://192.168.56.1:8000/api/products'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'product_id': productId,
//         'quantity': 1,
//         'customer_id': customerId,
//       }),
//     );

//     if (response.statusCode == 201) {
//       print('Added to cart');
//     } else {
//       print('Failed to add to cart');
//     }
//   }

//   Future<void> _showLoginDialog() async {
//     TextEditingController usernameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Login'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 TextField(
//                   controller: usernameController,
//                   decoration: InputDecoration(labelText: 'Username'),
//                 ),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Password'),
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Login'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _login(usernameController.text, passwordController.text);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _login(String username, String password) async {
//     String? customerId = await _getDeviceId();
//     setState(() {
//       _customerId = customerId;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products'),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: () => _showLoginDialog(),
//             icon: Icon(Icons.login),
//             label: Text('Login'),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()),
//               );
//             },
//             icon: Icon(Icons.person),
//             label: Text('Profile'),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: _products,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<dynamic> products = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(products[index]['name']),
//                   subtitle: Text('\$${products[index]['price']}'),
//                   trailing: ElevatedButton(
//                     onPressed: () async {
//                       String? customerId = _customerId ?? 'unknown';
//                       _addToCart(products[index]['id'], customerId);
//                     },
//                     child: Text('Add to Cart'),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CartPage(_customerId)),
//           );
//         },
//         label: Text('Cart'),
//         icon: Icon(Icons.shopping_cart),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'product.dart';

class ProductPage extends StatefulWidget {
  final String? customerId;

  ProductPage([this.customerId]);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> _products;
  String? _customerId;

  @override
  void initState() {
    super.initState();
    _products = _fetchProducts();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? customerId = widget.customerId ?? await _getDeviceId();
    setState(() {
      _customerId = customerId;
    });
  }

  Future<String?> _getDeviceId() async {
    // Implementasi untuk mendapatkan IP address
    return 'device_id_example';
  }

  Future<List<Product>> _fetchProducts() async {
    final response = await http.get(
      Uri.parse('http://192.168.56.1:8000/api/products'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> _addToCart(int productId, String customerId, int quantity) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/carts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
        'customer_id': customerId,
      }),
    );

    if (response.statusCode == 201) {
      print('Added to cart');
    } else {
      print('Failed to add to cart');
    }
  }

  Future<void> _showLoginDialog() async {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pop();
                _login(usernameController.text, passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(String username, String password) async {
    String? customerId = await _getDeviceId();
    setState(() {
      _customerId = customerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          ElevatedButton.icon(
            onPressed: () => _showLoginDialog(),
            icon: Icon(Icons.login),
            label: Text('Login'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.person),
            label: Text('Profile'),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product> products = snapshot.data ?? [];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: products[index],
                  customerId: _customerId ?? 'unknown',
                  addToCart: _addToCart,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(_customerId)),
          );
        },
        label: Text('Cart'),
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ProductListItem extends StatefulWidget {
  final Product product;
  final String customerId;
  final Function(int, String, int) addToCart;

  ProductListItem({
    required this.product,
    required this.customerId,
    required this.addToCart,
  });

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.name),
      subtitle: Text('\$${widget.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_quantity > 1) {
                  _quantity--;
                }
              });
            },
          ),
          Text(_quantity.toString()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              widget.addToCart(widget.product.id, widget.customerId, _quantity);
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}









