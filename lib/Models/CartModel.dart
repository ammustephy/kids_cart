import 'package:equatable/equatable.dart';

import 'ProductModel.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final Map<String, String> customizations;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
    this.customizations = const {},
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
    Map<String, String>? customizations,
  }) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      customizations: customizations ?? this.customizations,
    );
  }

  @override
  List<Object?> get props => [product.id, quantity, selectedColor, selectedSize, customizations];
}