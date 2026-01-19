import 'package:etronix/Models/admin_dashboard/product_model.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel product) onEdit;

  const ProductsGrid({super.key, required this.products, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.9,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(product: product, onEdit: () => onEdit(product));
      },
    );
  }
}
