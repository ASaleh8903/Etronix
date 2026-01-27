import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AdminCouponsSection extends StatelessWidget {
  const AdminCouponsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _section(
      title: "Coupons Applied",
      child: Column(
        children: const [
          _CouponRow(code: "WELCOME10", discount: "10%"),
          _CouponRow(code: "SALE50", discount: "50 EGP"),
        ],
      ),
    );
  }
}

class _CouponRow extends StatelessWidget {
  final String code, discount;
  const _CouponRow({required this.code, required this.discount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.local_offer, color: Colors.green),
      ),
      title: Text(code, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Text(discount, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ),
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