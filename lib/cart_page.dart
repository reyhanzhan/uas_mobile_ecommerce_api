// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:uas_mobile/profile_page.dart';

// class CartPage extends StatefulWidget {
//   final String? customerId;

//   CartPage(this.customerId);

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   List<Map<String, dynamic>> _cartItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCartItems();
//   }

//   Future<void> _loadCartItems() async {
//     String customerId = widget.customerId ?? 'unknown';
//     final response = await http.get(
//       Uri.parse('http://localhost/api/carts?customer_id=$customerId'),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         _cartItems = data.map((item) => Map<String, dynamic>.from(item)).toList();
//       });
//     } else {
//       print('Failed to load cart items');
//     }
//   }

//   Future<void> _editCartItem(int cartItemId, int quantity) async {
//     final response = await http.put(
//       Uri.parse('http://localhost/api/carts/$cartItemId'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'quantity': quantity}),
//     );

//     if (response.statusCode == 200) {
//       print('Updated cart item');
//       _loadCartItems();
//     } else {
//       print('Failed to update cart item');
//     }
//   }

//   Future<void> _deleteCartItem(int cartItemId) async {
//     final response = await http.delete(
//       Uri.parse('http://localhost/api/carts/$cartItemId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 204) {
//       print('Deleted cart item');
//       _loadCartItems();
//     } else {
//       print('Failed to delete cart item');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cart')),
//       body: ListView.builder(
//         itemCount: _cartItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Product ${_cartItems[index]['product_id']}'),
//             subtitle: Text('Quantity: ${_cartItems[index]['quantity']}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _editCartItem(_cartItems[index]['id'], _cartItems[index]['quantity'] + 1),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteCartItem(_cartItems[index]['id']),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProfilePage()),
//           );
//         },
//         label: Text('Profile'),
//         icon: Icon(Icons.person),
//       ),
//     );
//   }
// }

// ini ke dua
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'profile_page.dart';

// class CartPage extends StatefulWidget {
//   final String? customerId;

//   CartPage([this.customerId]);

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   List<Map<String, dynamic>> _cartItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCartItems();
//   }

//   Future<void> _loadCartItems() async {
//     String customerId = widget.customerId ?? 'unknown';
//     final response = await http.get(
//       Uri.parse('http://localhost/api/carts?customer_id=$customerId'),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         _cartItems =
//             data.map((item) => Map<String, dynamic>.from(item)).toList();
//       });
//     } else {
//       print('Failed to load cart items');
//     }
//   }

//   Future<void> _editCartItem(int cartItemId, int quantity) async {
//     final response = await http.put(
//       Uri.parse('http://localhost/api/carts/$cartItemId'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'quantity': quantity}),
//     );

//     if (response.statusCode == 200) {
//       print('Updated cart item');
//       _loadCartItems();
//     } else {
//       print('Failed to update cart item');
//     }
//   }

//   Future<void> _deleteCartItem(int cartItemId) async {
//     final response = await http.delete(
//       Uri.parse('http://localhost/api/carts/$cartItemId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 204) {
//       print('Deleted cart item');
//       _loadCartItems();
//     } else {
//       print('Failed to delete cart item');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Cart')),
//       body: ListView.builder(
//         itemCount: _cartItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Product ${_cartItems[index]['product_id']}'),
//             subtitle: Text('Quantity: ${_cartItems[index]['quantity']}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _editCartItem(_cartItems[index]['id'],
//                       _cartItems[index]['quantity'] + 1),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () => _deleteCartItem(_cartItems[index]['id']),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProfilePage()),
//           );
//         },
//         label: Text('Profile'),
//         icon: Icon(Icons.person),
//       ),
//     );
//   }
// }
// akhir ke dua


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'product.dart';

class CartPage extends StatelessWidget {
  final String? customerId;

  CartPage(this.customerId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return ListView.builder(
            itemCount: cartModel.cart.length,
            itemBuilder: (context, index) {
              final product = cartModel.cart[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('${product.price} x ${product.quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartModel.removeFromCart(product);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Text('Total: ${cartModel.getTotalPrice()}'),
          );
        },
      ),
    );
  }
}



