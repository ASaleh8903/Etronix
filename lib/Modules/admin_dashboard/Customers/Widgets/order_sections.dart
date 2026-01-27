import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AdminOrdersSection extends StatelessWidget {
  const AdminOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _section(
      title: "Recent Orders",
      child: Column(
        children: const [
          _OrderRow(id: "#ORD-1001", date: "12 Jan", total: "450 EGP"),
          _OrderRow(id: "#ORD-1002", date: "20 Jan", total: "300 EGP"),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String id, date, total;

  const _OrderRow({required this.id, required this.date, required this.total});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.receipt_long, color: Colors.blue),
      ),
      title: Text(id, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(date),
      trailing: Text(total, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
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