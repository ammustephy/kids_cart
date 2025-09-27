
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductCategory category;
  final List<String> colors;
  final List<String> sizes;
  final int ageMin;
  final int ageMax;
  final bool isCustomizable;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.colors = const [],
    this.sizes = const [],
    required this.ageMin,
    required this.ageMax,
    this.isCustomizable = false,
  });

  @override
  List<Object?> get props => [id, name, price, category];
}

enum ProductCategory { toys, clothing, accessories, learning }