import 'package:equatable/equatable.dart';
import 'package:ocius_cart/Models/ProductModel.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final ProductCategory? selectedCategory;
  final String searchQuery;

  ProductLoaded({
    required this.products,
    required this.filteredProducts,
    this.selectedCategory,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [products, filteredProducts, selectedCategory, searchQuery];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}