import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/utils.dart';

class AppProvider extends ChangeNotifier {
  static const baseUrl = "fakestoreapi.com";

  Cart _cart = Cart(id: 1, date: DateTime.now(), items: []);

  get cart => _cart;

  late User currentUserData;

  void addToCart(Item item, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final isItemInCart = _cart.items.any((cartItem) => cartItem.id == item.id);
    if (isItemInCart) {
      final SnackBar snackBar =
          getSnackbar(theme, 'error', 'Item already in cart');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _cart.items.add(item);

      final SnackBar snackBar =
          getSnackbar(theme, 'success', 'Item added to cart');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      notifyListeners();
    }
  }

  void updateItemQuantity(int itemId, int newQuantity) {
    final itemIndex = _cart.items.indexWhere((item) => item.id == itemId);

    if (itemIndex != -1) {
      _cart.items[itemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  void emptyCart() {
    _cart.items = [];
    notifyListeners();
  }

  String getTotalPrice() {
    double totalPrice = 0.0;

    for (var item in _cart.items) {
      totalPrice += item.price * item.quantity;
    }

    String formattedTotalPrice = totalPrice.toStringAsFixed(2);

    if (formattedTotalPrice.endsWith('.0')) {
      formattedTotalPrice += '0';
    }

    return formattedTotalPrice;
  }

  Future<bool> login(body) async {
    final url = Uri.https(baseUrl, '/auth/login');
    try {
      final Response response = await http.post(url,
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(body));
      switch (response.statusCode) {
        case 200:
          currentUserData = await getUserData(body["username"]);
          return true;

        case 401:
        default:
          return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<dynamic> getUserData(currentUsername) async {
    final url = Uri.https(baseUrl, '/users');
    try {
      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<User> allUsers = [];

        final decodedResponse = json.decode(response.body);
        for (var user in decodedResponse) {
          allUsers.add(User.fromJson(user));
        }
        final currentUserData =
            allUsers.firstWhere((user) => user.username == currentUsername);
        return currentUserData;
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'No user found';
    }
  }

  Future<List> getCategories() async {
    final url = Uri.https(baseUrl, '/products/categories');
    List categoriesList = [];
    try {
      final Response response = await http.get(url);
      categoriesList = json.decode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return categoriesList;
  }

  Future<List> getProductsByCategory(String category) async {
    final url = Uri.https(baseUrl, '/products/category/$category');
    List<Product> products = [];
    try {
      final Response response = await http.get(url);
      final responseBody = json.decode(response.body);
      for (var product in responseBody) {
        final tempProduct = Product.fromJson(product);
        products.add(tempProduct);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return products;
  }

  Future<Product> getFeaturedProduct() async {
    final url = Uri.https(baseUrl, '/products');
    List<Product> products = [];
    try {
      final Response response = await http.get(url);
      final responseBody = json.decode(response.body);
      for (var product in responseBody) {
        final tempProduct = Product.fromJson(product);
        products.add(tempProduct);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    final random = Random();
    Product product = products[random.nextInt(products.length)];
    return product;
  }

  Future<List<Product>> getProducts() async {
    final url = Uri.https(baseUrl, '/products');
    List<Product> products = [];
    try {
      final Response response = await http.get(url);
      final responseBody = json.decode(response.body);
      for (var product in responseBody) {
        final tempProduct = Product.fromJson(product);
        products.add(tempProduct);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return products;
  }

  Future<Cart> getCart() async {
    _cart = cart;
    return cart;
  }

  void reset() {
    _cart = Cart(id: 1, date: DateTime.now(), items: []);
    notifyListeners();
  }
}
