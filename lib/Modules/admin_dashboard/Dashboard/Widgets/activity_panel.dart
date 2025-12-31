import 'package:flutter/material.dart';
import 'hover_card.dart';

class ActivityPanel extends StatelessWidget {
  const ActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Recent Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ActivityItem(title: 'New order placed'),
          ActivityItem(title: 'Product updated'),
          ActivityItem(title: 'User registered'),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String title;

  const ActivityItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
