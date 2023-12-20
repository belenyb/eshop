import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/api_provider.dart';
import '../widgets/all_products.dart';
import '../widgets/cart.dart';
import '../widgets/categories.dart';
import '../widgets/featured_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiProvider apiProvider =
        Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/eshop-logo.png',
          fit: BoxFit.fitHeight,
          height: 70,
        ),
        backgroundColor: const Color(0xfff4f4f4),
        elevation: 0,
        actions: const [
          CartButton(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            FeaturedProduct(apiProvider: apiProvider),
            const SizedBox(height: 32),
            CategoriesWidget(apiProvider: apiProvider),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllProducts(
                            apiProvider: apiProvider,
                          ),
                        ),
                      ),
                      child: const Text(
                        "SEE ALL",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                AllProducts(apiProvider: apiProvider, itemCount: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
