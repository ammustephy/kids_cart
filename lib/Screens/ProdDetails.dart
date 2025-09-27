import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Models/CartModel.dart';
import 'package:ocius_cart/Models/ProductModel.dart';
import 'package:ocius_cart/bloc/cart_bloc.dart';
import 'package:ocius_cart/bloc/cart_event.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;
  Map<String, String> customizations = {};

  @override
  void initState() {
    super.initState();
    print('CartBloc available in ProductDetailScreen: ${context.read<CartBloc>() != null}');
    if (widget.product.colors.isNotEmpty) {
      selectedColor = widget.product.colors.first;
    }
    if (widget.product.sizes.isNotEmpty) {
      selectedSize = widget.product.sizes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.blue[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.product.imageUrl,
              height: 300,
              width: 300,
              // fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Perfect for ages ${widget.product.ageMin}-${widget.product.ageMax}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  if (widget.product.colors.isNotEmpty) ...[
                    Text('Colors:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.product.colors.map((color) {
                        return ChoiceChip(
                          label: Text(color),
                          selected: selectedColor == color,
                          onSelected: (selected) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                  ],

                  if (widget.product.sizes.isNotEmpty) ...[
                    Text('Sizes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.product.sizes.map((size) {
                        return ChoiceChip(
                          label: Text(size),
                          selected: selectedSize == size,
                          onSelected: (selected) {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                  ],

                  if (widget.product.isCustomizable) ...[
                    CustomizationSection(
                      onCustomizationChanged: (customization) {
                        setState(() {
                          customizations = customization;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                  ],

                  Row(
                    children: [
                      Text('Quantity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                        icon: Icon(Icons.remove),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('$quantity', style: TextStyle(fontSize: 18)),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final cartItem = CartItem(
                          product: widget.product,
                          quantity: quantity,
                          selectedColor: selectedColor,
                          selectedSize: selectedSize,
                          customizations: customizations,
                        );

                        context.read<CartBloc>().add(AddToCart(cartItem));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('🎉 Added to cart!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        '🛒 Add to Cart - ${(widget.product.price * quantity).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomizationSection extends StatefulWidget {
  final Function(Map<String, String>) onCustomizationChanged;

  const CustomizationSection({required this.onCustomizationChanged});

  @override
  _CustomizationSectionState createState() => _CustomizationSectionState();
}

class _CustomizationSectionState extends State<CustomizationSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('✨ Customization:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Add a name',
            hintText: 'Enter child\'s name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (value) {
            widget.onCustomizationChanged({
              'name': value,
              'message': _messageController.text,
            });
          },
        ),
        SizedBox(height: 12),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Special message',
            hintText: 'Add a special message',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(Icons.message),
          ),
          maxLines: 2,
          onChanged: (value) {
            widget.onCustomizationChanged({
              'name': _nameController.text,
              'message': value,
            });
          },
        ),
      ],
    );
  }
}