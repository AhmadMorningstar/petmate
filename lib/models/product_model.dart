import 'package:flutter/material.dart';

class ProductModel {
  String image, name, description, category;
  double price;
  Color color;
  int id; // Ensure this is NOT nullable

  ProductModel({
    required this.price,
    required this.image,
    required this.id, // Now required
    required this.color,
    required this.category,
    required this.name,
    required this.description,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0, // Ensure id is never null
        name = json['name'] ?? '',
        color = getColor(json['color']),
        category = json['category'] ?? '',
        price = double.parse(json['price'].toString()),
        description = json['description'] ?? '',
        image = json['image'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value, // Store color as int
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  static Color getColor(dynamic colorValue) {
    if (colorValue is int) {
      return Color(colorValue);
    } else if (colorValue is String) {
      return Color(int.parse(colorValue));
    }
    return Colors.white;
  }
}
