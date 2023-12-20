import 'package:ecommerce_app/screens/products_by_category.dart';
import 'package:flutter/material.dart';

import '../resources/app_provider.dart';
import '../utils/utils.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.apiProvider,
  }) : super(key: key);

  final AppProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 16),
        FutureBuilder(
          future: apiProvider.getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsByCategoryScreen(
                            category: snapshot.data[index],
                            apiProvider: apiProvider,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.all(4),
                        width: (MediaQuery.of(context).size.width / 4) - 16,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(2, 2),
                                  spreadRadius: 1,
                                  blurRadius: 16)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getIcon(snapshot.data[index]),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  capitalize(snapshot.data[index]),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
