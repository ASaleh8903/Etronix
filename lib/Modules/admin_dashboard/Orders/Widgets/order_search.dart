import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class OrdersSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const OrdersSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Search orders...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
