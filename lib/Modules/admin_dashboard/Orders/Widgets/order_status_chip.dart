import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status == 'Completed'
        ? AppColors.success
        : AppColors.warning;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}
