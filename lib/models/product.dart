import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int size;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.size,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? size,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'size': size,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      size: json['size'], 
    );
  }

}