import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomerStats extends StatelessWidget {
  const CustomerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            title: "Total Orders",
            value: "5",
            icon: Icons.shopping_cart,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: "Total Spent",
            value: "750 EGP",
            icon: Icons.attach_money,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: "Coupons Used",
            value: "3",
            icon: Icons.local_offer,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isHovered ? AppColors.primary : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.08 : 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, size: 26, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  Text(
                    widget.value,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}