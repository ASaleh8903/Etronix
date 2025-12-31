import 'package:flutter/material.dart';
import 'hover_card.dart';

class SystemNotifications extends StatelessWidget {
  const SystemNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'System Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          NotificationItem(text: 'Payment failed for order #1024'),
          NotificationItem(text: 'New product review added'),
          NotificationItem(text: 'Low stock warning triggered'),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String text;

  const NotificationItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.notifications_none),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
