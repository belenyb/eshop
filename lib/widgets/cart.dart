import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../resources/app_provider.dart';
import '../screens/cart.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartScreen(),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
            size: 40,
          ),
          Consumer<AppProvider>(
            builder: (context, apiProvider, child) {
              final List<Item> cartItems = apiProvider.cart.items;

              int totalQuantity = 0;
              for (var item in cartItems) {
                totalQuantity += item.quantity;
              }

              if (totalQuantity > 0) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 183, 0, 0),
                      shape: BoxShape.circle),
                  child: Text(
                    totalQuantity.toString(),
                    style: theme.textTheme.labelMedium!
                        .copyWith(color: Colors.white),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
