import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Models/ProductModel.dart';
import 'package:ocius_cart/bloc/product_event.dart';
import 'package:ocius_cart/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Rainbow Building Blocks',
      description: 'Colorful wooden blocks for creative building',
      price: 200,
      imageUrl: 'Assets/Images/Rainbow Building Blocks.jpg',
      category: ProductCategory.toys,
      ageMin: 2,
      ageMax: 8,
      isCustomizable: true,
    ),
    Product(
      id: '2',
      name: 'Superhero Cape',
      description: 'Let your child become their favorite superhero',
      price: 300,
      imageUrl: 'Assets/Images/Superhero Capes.jpg',
      category: ProductCategory.clothing,
      sizes: ['Small', 'Medium', 'Large'],
      ageMin: 3,
      ageMax: 10,
      isCustomizable: true,
    ),
    Product(
      id: '3',
      name: 'Magic Backpack',
      description: 'Spacious and fun backpack for school adventures',
      price: 450,
      imageUrl: 'Assets/Images/Magic Backpack.jpg',
      category: ProductCategory.accessories,
      colors: ['Blue'],
      ageMin: 4,
      ageMax: 12,
      isCustomizable: true,
    ),
    Product(
      id: '4',
      name: 'ABC Learning Puzzle',
      description: 'Interactive puzzle to learn letters and words',
      price: 150,
      imageUrl: 'Assets/Images/ABC Learning Puzzle.jpg',
      category: ProductCategory.learning,
      ageMin: 3,
      ageMax: 6,
    ),
    Product(
      id: '5',
      name: 'Teddy Bear Friend',
      description: 'Soft and cuddly companion for bedtime',
      price: 400,
      imageUrl: 'Assets/Images/Teddy Bear Friend.jpg',
      category: ProductCategory.toys,
      colors: ['Brown'],
      sizes: ['Small', 'Medium', 'Large'],
      ageMin: 0,
      ageMax: 10,
      isCustomizable: true,
    ),
    Product(
      id: '6',
      name: 'Princess Dress',
      description: 'Beautiful dress for royal adventures',
      price: 800,
      imageUrl: 'Assets/Images/Princess Dress.jpg',
      category: ProductCategory.clothing,
      colors: ['Maroon'],
      sizes: ['2T', '3T', '4T', '5T'],
      ageMin: 2,
      ageMax: 6,
      isCustomizable: true,
    ),
  ];

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    emit(ProductLoaded(
      products: _allProducts,
      filteredProducts: _allProducts,
    ));
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final filtered = event.category == null
          ? _allProducts
          : _allProducts.where((p) => p.category == event.category).toList();

      emit(ProductLoaded(
        products: _allProducts,
        filteredProducts: filtered,
        selectedCategory: event.category,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final query = event.query.toLowerCase();
      final filtered = _allProducts.where((p) =>
      p.name.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query)
      ).toList();

      emit(ProductLoaded(
        products: _allProducts,
        filteredProducts: filtered,
        selectedCategory: currentState.selectedCategory,
        searchQuery: event.query,
      ));
    }
  }
}