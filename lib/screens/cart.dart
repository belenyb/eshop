import 'package:ecommerce_app/resources/app_provider.dart';
import 'package:ecommerce_app/widgets/numeric_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/custom_dialog.dart';
import 'home.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: appProvider.getCart(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final List<Item> cartItems = snapshot.data.items;
              return cartItems.isEmpty
                  ? Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.production_quantity_limits),
                        const SizedBox(width: 8),
                        Text("Shopping cart is empty",
                            style: theme.textTheme.labelLarge),
                      ],
                    ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'Are you sure?',
                                content: 'All items in cart will be removed',
                                onAction: () {
                                  appProvider.emptyCart();
                                  Navigator.pop(context);
                                },
                                onActionLabel: '🗑️ Empty cart',
                              );
                            },
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.remove_shopping_cart_outlined,
                                  color: theme.colorScheme.error),
                              const SizedBox(width: 8),
                              Text(
                                "Empty cart",
                                style:
                                    TextStyle(color: theme.colorScheme.error),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Item cartItem = cartItems[index];
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(2, 2),
                                            spreadRadius: 1,
                                            blurRadius: 16)
                                      ]),
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Image.network(
                                                cartItem.image,
                                                width: 60,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cartItem.title,
                                                    style: theme
                                                        .textTheme.titleMedium,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "\$${cartItem.price.toString()}",
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      NumericInput(
                                        initialValue: cartItem.quantity,
                                        onChanged: (value) {
                                          appProvider.updateItemQuantity(
                                              cartItem.id, value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total: ", style: theme.textTheme.titleMedium),
              Text(
                "\$${appProvider.getTotalPrice()}",
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () => showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: 'End of app 😊',
                    content:
                        'Feel free to click "Cancel" to resume from where you left off, or hit "Restart" for another attempt.',
                    onActionLabel: '🔄 Restart',
                    onAction: () {
                      Provider.of<AppProvider>(context, listen: false).reset();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                  );
                }),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  "Buy now",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
