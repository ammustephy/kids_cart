import 'package:equatable/equatable.dart';

import '../Models/ProductModel.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class FilterByCategory extends ProductEvent {
  final ProductCategory? category;
  FilterByCategory(this.category);
  @override
  List<Object?> get props => [category];
}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
  @override
  List<Object?> get props => [query];
}