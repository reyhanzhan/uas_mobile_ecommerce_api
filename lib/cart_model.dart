import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(Product product, int quantity) {
    _cart.add(CartItem(
      id: UniqueKey().toString(),
      product: product,
      quantity: quantity,
    ));
    addToCartApi('customer_id_example', product.id, quantity, product.price); // Panggil API untuk menambahkan ke database
    notifyListeners();
  }

  void remove(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cart.remove(cartItem);
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cart.remove(cartItem);
    notifyListeners();
  }

  void updateQuantity(CartItem cartItem, int quantity) {
    cartItem.quantity = quantity;
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var cartItem in _cart) {
      total += cartItem.product.price * cartItem.quantity;
    }
    return total;
  }

  Future<void> addToCartApi(String customerId, int productId, int quantity, double productPrice) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/carts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'customer_id': customerId,
        'product_id': productId,
        'quantity': quantity,
        'product_price': productPrice,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add to cart');
    }
  }
}

class CartItem {
  final String id;
  final Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });
}
