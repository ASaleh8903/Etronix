import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';


class CustomerCard extends StatefulWidget {
  final Map<String, dynamic> customer;
  final VoidCallback onTap;

  const CustomerCard({super.key, required this.customer, required this.onTap});

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: isHovered
              ? (Matrix4.identity()..translate(0, -8))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered ? AppColors.primary : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black.withOpacity(0.05),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person, size: 40),
              const SizedBox(height: 12),
              Text(widget.customer['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.customer['phone']),
              const Spacer(),
              Text('Orders: ${widget.customer['totalOrders']}'),
              Text('Spent: ${widget.customer['totalSpent']} EGP',
                  style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
