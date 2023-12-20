import 'dart:convert';

class Cart {
  int id;
  DateTime date;
  List<Item> items;

  Cart({
    required this.id,
    required this.date,
    required this.items,
  });

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        items: json["items"] == [] ? [] : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  String title;
  double price;
  String image;
  int quantity;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "image": image,
        "quantity": quantity,
      };
}
