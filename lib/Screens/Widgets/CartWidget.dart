import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Models/CartModel.dart';
import 'package:ocius_cart/bloc/cart_bloc.dart';
import 'package:ocius_cart/bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    item.product.imageUrl,
                    maxWidth: 80,
                    maxHeight: 80,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  if (item.selectedColor != null)
                    Text('Color: ${item.selectedColor}', style: TextStyle(color: Colors.grey[600])),
                  if (item.selectedSize != null)
                    Text('Size: ${item.selectedSize}', style: TextStyle(color: Colors.grey[600])),
                  if (item.customizations.isNotEmpty) ...[
                    if (item.customizations['name']?.isNotEmpty == true)
                      Text('Name: ${item.customizations['name']}', style: TextStyle(color: Colors.blue[600])),
                    if (item.customizations['message']?.isNotEmpty == true)
                      Text('Message: ${item.customizations['message']}', style: TextStyle(color: Colors.blue[600])),
                  ],
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.totalPrice.toStringAsFixed(2)}', // Fixed string interpolation
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green[600]),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                UpdateCartItem(item.product.id, item.quantity - 1),
                              );
                            },
                            icon: Icon(Icons.remove),
                            constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('${item.quantity}'),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                UpdateCartItem(item.product.id, item.quantity + 1),
                              );
                            },
                            icon: Icon(Icons.add),
                            constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8), // Added spacing to prevent overflow
            IconButton(
              onPressed: () {
                context.read<CartBloc>().add(RemoveFromCart(item.product.id));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item removed from cart'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              icon: Icon(Icons.delete, color: Colors.red),
              constraints: BoxConstraints(minWidth: 40, minHeight: 40), // Constrain delete button size
            ),
          ],
        ),
      ),
    );
  }
}