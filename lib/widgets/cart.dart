import 'package:flutter/material.dart';
import '../screens/cart.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.black,
          size: 30,
        ));
  }
}
