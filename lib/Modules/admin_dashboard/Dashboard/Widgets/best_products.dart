import 'package:flutter/material.dart';
import 'hover_card.dart';

class BestProducts extends StatelessWidget {
  const BestProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Best Selling Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ProductItem(name: 'iPhone 14', sales: '320 sales'),
          ProductItem(name: 'AirPods Pro', sales: '210 sales'),
          ProductItem(name: 'MacBook Pro', sales: '180 sales'),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String sales;

  const ProductItem({super.key, required this.name, required this.sales});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_outlined),
          const SizedBox(width: 12),
          Expanded(child: Text(name)),
          Text(
            sales,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
