import 'package:ecommerce_app/resources/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../utils/utils.dart';
import '../widgets/numeric_input.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    int productQuantity = 1;
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Hero(
                        tag: 'productWidgetImage',
                        child: Image.network(
                          product.image,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Text(capitalize(product.category)),
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
                        RatingBar.builder(
                          initialRating: product.rating.rate,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          unratedColor:
                              const Color.fromARGB(255, 189, 189, 189),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 213, 86),
                          ),
                          onRatingUpdate: (rating) {
                            debugPrint("rating updated to: $rating");
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(product.rating.rate.toString()),
                        Text(" (${product.rating.count.toString()} ratings)"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.description,
                      style: theme.textTheme.caption,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Row(
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
                    appProvider.addToCart(
                        Item(
                          id: product.id,
                          title: product.title,
                          price: product.price,
                          image: product.image,
                          quantity: productQuantity,
                        ),
                        context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
