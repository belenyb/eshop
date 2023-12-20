import 'package:ecommerce_app/resources/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../widgets/numeric_input.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ApiProvider apiProvider =
        Provider.of<ApiProvider>(context, listen: false);
    int productQuantity = 1;
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product.image,
                    height: 300,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(product.category),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: theme.textTheme.headline6,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "\$${product.price.toString()}",
                      style: theme.textTheme.headline6,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text("⭐⭐⭐⭐⭐"),
                    Text(product.rating.rate.toString()),
                    Text(" (${product.rating.count.toString()} ratings)"),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumericInput(
                    onChanged: (value) {
                      productQuantity = value;
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Add to cart',
                    ),
                    onPressed: () {
                      apiProvider.addToCart(Item(
                        id: product.id,
                        title: product.title,
                        price: product.price,
                        image: product.image,
                        quantity: productQuantity,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
