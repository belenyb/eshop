import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.product,
    required this.theme,
  }) : super(key: key);

  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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
            borderRadius:
                const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(2, 2),
                  spreadRadius: 1.5,
                  blurRadius: 24)
            ]),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Image.network(
            product.image,
            height: 250,
          ),
          const SizedBox(height: 32),
          Text(
            product.title,
            style: theme.textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "\$${product.price.toString()}",
            style: theme.textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
    );
  }
}
