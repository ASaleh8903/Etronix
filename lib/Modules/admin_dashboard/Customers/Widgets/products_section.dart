import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AdminProductsSection extends StatelessWidget {
  const AdminProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _section(
      title: "Purchased Products",
      child: Column(
        children: const [
          _ProductRow(name: "T-Shirt Black", qty: "x2", price: "400 EGP"),
          _ProductRow(name: "Sneakers White", qty: "x1", price: "350 EGP"),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final String name, qty, price;
  const _ProductRow({required this.name, required this.qty, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.inventory_2, color: Colors.orange),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(qty),
      trailing: Text(price),
    );
  }
}

Widget _section({required String title, required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 18, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}