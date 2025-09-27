import 'package:equatable/equatable.dart';

import '../Models/CartModel.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String productId;
  RemoveFromCart(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateCartItem extends CartEvent {
  final String productId;
  final int quantity;
  UpdateCartItem(this.productId, this.quantity);
  @override
  List<Object?> get props => [productId, quantity];
}

class ClearCart extends CartEvent {}