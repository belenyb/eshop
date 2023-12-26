import 'package:ecommerce_app/resources/app_provider.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product.dart';

class AllProducts extends StatelessWidget {
  final AppProvider appProvider;
  final int? itemCount;
  const AllProducts({super.key, required this.appProvider, this.itemCount});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return itemCount != null
        ? FutureBuilder(
            future: appProvider.getProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount ?? snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Product product = snapshot.data[index];
                    return ProductWidget(product: product, theme: theme);
                  },
                );
              }
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("All products"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: appProvider.getProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemCount ?? snapshot.data.length,
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
