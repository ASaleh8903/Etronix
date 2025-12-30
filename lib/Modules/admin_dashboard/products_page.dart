import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: Text(
          'Products',
          style: TextStyle(fontSize: 2, color: Colors.black),
        ),
      ),
    );
  }
}
