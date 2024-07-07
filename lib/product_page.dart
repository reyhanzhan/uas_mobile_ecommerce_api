import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'product.dart';
import 'cart_model.dart';
import 'package:provider/provider.dart';

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
      Uri.parse('https://mobileappuaskelaspagi10.000webhostapp.com/api/products'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
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

  ProductListItem({
    required this.product,
    required this.customerId,
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
              Provider.of<CartModel>(context, listen: false).addToCart(
                widget.product,
                _quantity,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.product.name} added to cart')),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
