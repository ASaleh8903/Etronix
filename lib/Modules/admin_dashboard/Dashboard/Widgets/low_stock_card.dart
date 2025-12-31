import 'package:flutter/material.dart';
import 'hover_card.dart';

class LowStockCard extends StatelessWidget {
  const LowStockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Low Stock Alerts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          StockItem(name: 'iPhone 13', count: 3),
          StockItem(name: 'Wireless Mouse', count: 0),
        ],
      ),
    );
  }
}

class StockItem extends StatelessWidget {
  final String name;
  final int count;

  const StockItem({super.key, required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    final isOut = count == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: isOut ? Colors.red : Colors.orange,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(name)),
          Text(
            isOut ? 'Out of stock' : '$count left',
            style: TextStyle(
              color: isOut ? Colors.red : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
