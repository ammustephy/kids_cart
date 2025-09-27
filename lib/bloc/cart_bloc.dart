import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Models/CartModel.dart';
import 'package:ocius_cart/bloc/cart_event.dart';
import 'package:ocius_cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super( CartEmpty()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<ClearCart>(_onClearCart);
  }

  List<CartItem> _items = [];

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    print('AddToCart event received: ${event.item.product.name}, Quantity: ${event.item.quantity}');
    // Create a new list to ensure immutability
    final updatedItems = List<CartItem>.from(_items);
    final existingIndex = updatedItems.indexWhere(
          (item) =>
      item.product.id == event.item.product.id &&
          item.selectedColor == event.item.selectedColor &&
          item.selectedSize == event.item.selectedSize,
    );

    if (existingIndex >= 0) {
      print('Updating existing item at index $existingIndex');
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + event.item.quantity,
      );
    } else {
      print('Adding new item to cart');
      updatedItems.add(event.item);
    }

    // Update the internal _items list
    _items = updatedItems;

    // Calculate total and emit new state
    final total = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
    print('Emitting CartLoaded with ${_items.length} items, total: $total');
    emit(CartLoaded(List<CartItem>.from(_items), total));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    print('RemoveFromCart event received for productId: ${event.productId}');
    // Create a new list to ensure immutability
    final updatedItems = List<CartItem>.from(_items)
      ..removeWhere((item) => item.product.id == event.productId);

    // Update the internal _items list
    _items = updatedItems;

    if (_items.isEmpty) {
      print('Emitting CartEmpty');
      emit( CartEmpty());
    } else {
      final total = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
      print('Emitting CartLoaded with ${_items.length} items, total: $total');
      emit(CartLoaded(List<CartItem>.from(_items), total));
    }
  }

  void _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) {
    print('UpdateCartItem event received for productId: ${event.productId}, quantity: ${event.quantity}');
    // Create a new list to ensure immutability
    final updatedItems = List<CartItem>.from(_items);
    final index = updatedItems.indexWhere((item) => item.product.id == event.productId);

    if (index >= 0) {
      if (event.quantity <= 0) {
        print('Removing item at index $index');
        updatedItems.removeAt(index);
      } else {
        print('Updating item quantity at index $index to ${event.quantity}');
        updatedItems[index] = updatedItems[index].copyWith(quantity: event.quantity);
      }
    }

    // Update the internal _items list
    _items = updatedItems;

    if (_items.isEmpty) {
      print('Emitting CartEmpty');
      emit( CartEmpty());
    } else {
      final total = _items.fold(0.0, (sum, item) => sum + item.totalPrice);
      print('Emitting CartLoaded with ${_items.length} items, total: $total');
      emit(CartLoaded(List<CartItem>.from(_items), total));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    print('ClearCart event received');
    _items = [];
    emit( CartEmpty());
  }
}