import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../resources/app_provider.dart';
import '../utils/utils.dart';
import '../widgets/all_products.dart';
import '../widgets/cart.dart';
import '../widgets/categories.dart';
import '../widgets/featured_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: MyAppBar(appProvider: appProvider)),
      endDrawer: UserDrawer(user: appProvider.currentUserData),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(top: 16),
        child: ListView(
          children: [
            FeaturedProduct(appProvider: appProvider),
            const SizedBox(height: 32),
            CategoriesWidget(appProvider: appProvider),
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
                            appProvider: appProvider,
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
                AllProducts(appProvider: appProvider, itemCount: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserDrawer extends StatelessWidget {
  final User user;
  const UserDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Center(
              child: DrawerHeader(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: theme.colorScheme.onPrimary,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text('Profile information',
                        style: theme.textTheme.titleLarge!
                            .copyWith(color: theme.colorScheme.onPrimary)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(capitalize(user.name.firstname)),
            subtitle: const Text("Name"),
          ),
          ListTile(
            title: Text(capitalize(user.name.lastname)),
            subtitle: const Text("Lastname"),
          ),
          ListTile(
            title: Text("@${user.username}"),
            subtitle: const Text("Username"),
          ),
          ListTile(
            title: Text(user.email),
            subtitle: const Text("Email"),
          ),
          ListTile(
            title: Text(user.phone),
            subtitle: const Text("Phone"),
          ),
          ListTile(
            title: Text(
                "${capitalize(user.address.street)} ${user.address.number}, ${capitalize(user.address.city)}"),
            subtitle: const Text("Address"),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final AppProvider appProvider;
  const MyAppBar({
    Key? key,
    required this.appProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/images/eshop-logo.png',
        fit: BoxFit.fitHeight,
        height: 60,
      ),
      backgroundColor: const Color(0xfff4f4f4),
      elevation: 0,
      actions: [
        const CartButton(),
        GestureDetector(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: const Icon(
            Icons.person_outline,
            color: Colors.black,
            size: 40,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
