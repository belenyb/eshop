import 'package:ecommerce_app/resources/api_provider.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product.dart';

class FeaturedProduct extends StatelessWidget {
  final ApiProvider apiProvider;
  const FeaturedProduct({super.key, required this.apiProvider});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 16),
        FutureBuilder(
          future: apiProvider.getFeaturedProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final Product product = snapshot.data;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(
                      product: product,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "\$${product.price.toString()}",
                              style: theme.textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Image.network(
                          product.image,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
