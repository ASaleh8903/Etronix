import 'package:flutter/material.dart';
import 'hover_card.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _statusItem('Pending', 14, Colors.orange),
          _statusItem('Processing', 8, Colors.blue),
          _statusItem('Shipped', 22, Colors.green),
          _statusItem('Cancelled', 3, Colors.red),
        ],
      ),
    );
  }

  Widget _statusItem(String title, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
          Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
