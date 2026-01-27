import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/coupons_section.dart';
import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/customer_header.dart';
import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/customer_stat.dart';
import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/order_sections.dart';
import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/products_section.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Customer Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            RevealOnScroll(
              child: _animatedItem(child: const CustomerHeader(), delay: 0),
            ),
            const SizedBox(height: 20),
            RevealOnScroll(
              child: _animatedItem(child: const CustomerStats(), delay: 1),
            ),
            const SizedBox(height: 24),
            RevealOnScroll(
              child: _animatedItem(child: const AdminOrdersSection(), delay: 2),
            ),
            const SizedBox(height: 24),
            RevealOnScroll(
              child: _animatedItem(
                child: const AdminProductsSection(),
                delay: 3,
              ),
            ),
            const SizedBox(height: 24),
            RevealOnScroll(
              child: _animatedItem(
                child: const AdminCouponsSection(),
                delay: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedItem({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (delay * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
