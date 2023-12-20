import 'package:ecommerce_app/resources/api_provider.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/utils.dart';
import '../widgets/product.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String category;
  final ApiProvider apiProvider;
  const ProductsByCategoryScreen(
      {super.key, required this.category, required this.apiProvider});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(category)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: apiProvider.getProductsByCategory(category),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final Product product = snapshot.data[index];
                  return ProductWidget(product: product, theme: theme);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
