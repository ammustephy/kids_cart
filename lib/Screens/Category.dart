import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Models/ProductModel.dart';
import 'package:ocius_cart/bloc/product_bloc.dart';
import 'package:ocius_cart/bloc/product_event.dart';
import 'package:ocius_cart/bloc/product_state.dart';

class CategoryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is! ProductLoaded) return SizedBox();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategoryChip(
                label: 'All',
                category: null,
                isSelected: state.selectedCategory == null,
              ),
              CategoryChip(
                label: 'Toys',
                category: ProductCategory.toys,
                isSelected: state.selectedCategory == ProductCategory.toys,
              ),
              CategoryChip(
                label: 'Clothing',
                category: ProductCategory.clothing,
                isSelected: state.selectedCategory == ProductCategory.clothing,
              ),
              CategoryChip(
                label: 'Accessories',
                category: ProductCategory.accessories,
                isSelected: state.selectedCategory == ProductCategory.accessories,
              ),
              CategoryChip(
                label: 'Learning',
                category: ProductCategory.learning,
                isSelected: state.selectedCategory == ProductCategory.learning,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final ProductCategory? category;
  final bool isSelected;

  const CategoryChip({
    required this.label,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        selected: isSelected,
        onSelected: (selected) {
          context.read<ProductBloc>().add(FilterByCategory(category));
        },
        selectedColor: Colors.yellow[300],
        backgroundColor: Colors.white,
        labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.grey[600]),
      ),
    );
  }
}

