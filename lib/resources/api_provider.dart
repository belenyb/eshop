import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/cart.dart';
import '../models/product.dart';

class ApiProvider extends ChangeNotifier {
  static const baseUrl = "fakestoreapi.com";
  Cart _cart = Cart(id: 1, date: DateTime.now(), items: []);

  get cart => _cart;

  void addToCart(Item item) {
    //TODO if item already exists in cart, put snackbar and prevent adding to cart
    _cart.items.add(item);
    notifyListeners();
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
}
