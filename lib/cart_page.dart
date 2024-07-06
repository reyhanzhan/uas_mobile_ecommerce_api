import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

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
              final cartItem = cartModel.cart[index];
              final productTotal = cartItem.product.price * cartItem.quantity;
              return ListTile(
                title: Text(cartItem.product.name),
                subtitle: Text('${cartItem.product.price} x ${cartItem.quantity} total $productTotal'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: cartItem.quantity > 1
                          ? () {
                              cartModel.updateQuantity(cartItem, cartItem.quantity - 1);
                            }
                          : null, // Tombol dinonaktifkan jika kuantitas adalah 1
                    ),
                    Text(cartItem.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cartModel.updateQuantity(cartItem, cartItem.quantity + 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () => _showRemoveDialog(context, cartModel, cartItem),
                    ),
                  ],
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
            child: Text('Total Price: ${cartModel.getTotalPrice()}'),
          );
        },
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, CartModel cartModel, CartItem cartItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Are you sure to remove ${cartItem.product.name}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                cartModel.removeFromCart(cartItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
