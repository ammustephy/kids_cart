
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocius_cart/Screens/Home.dart';
import 'package:ocius_cart/bloc/product_bloc.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/product_event.dart';


void main() {
  runApp(KidsStoreApp());
}

class KidsStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Comic Sans MS',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductBloc()..add(LoadProducts())),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}













