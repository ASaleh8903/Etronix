import 'package:flutter/material.dart';
import 'hover_card.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Icon(
                Icons.show_chart,
                size: 80,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
