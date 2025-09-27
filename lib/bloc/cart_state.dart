import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:ocius_cart/Models/CartModel.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartEmpty extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalAmount;

  const CartLoaded(this.items, this.totalAmount);

  @override
  List<Object?> get props => [items, totalAmount];

  // Ensure deep comparison for items list
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartLoaded &&
              runtimeType == other.runtimeType &&
              totalAmount == other.totalAmount &&
              const DeepCollectionEquality().equals(items, other.items);

  @override
  int get hashCode => totalAmount.hashCode ^ const DeepCollectionEquality().hash(items);
}