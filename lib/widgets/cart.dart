import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../resources/api_provider.dart';
import '../screens/cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/api_provider.dart';
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
          Consumer<ApiProvider>(
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
                      color: Colors.redAccent, shape: BoxShape.circle),
                  child: Text(
                    totalQuantity.toString(),
                    style: theme.textTheme.labelSmall!
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


// class CartButton extends StatelessWidget {
//   const CartButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final List cartItems =
//         Provider.of<ApiProvider>(context).cart.items;
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const CartScreen(),
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           const Icon(
//             Icons.shopping_cart_outlined,
//             color: Colors.black,
//             size: 40,
//           ),
//           if (cartItems.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.all(5),
//               decoration: const BoxDecoration(
//                   color: Colors.redAccent, shape: BoxShape.circle),
//               child: Text(cartItems[0].quantity.toString(),
//                   style: theme.textTheme.labelSmall!
//                       .copyWith(color: Colors.white)),
//             ),
//         ],
//       ),
//     );
//   }
// }
