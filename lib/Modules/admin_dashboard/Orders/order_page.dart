import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/Filter/applied_filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'Widgets/order_search.dart';
import 'Widgets/orders_pagination.dart';
import 'Widgets/orders_table.dart';
import 'Widgets/order_details_drawer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool showDrawer = false;
  int currentPage = 1;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildMainContent(),

          OrderDetailsDrawer(
            isOpen: showDrawer,
            onClose: () => setState(() => showDrawer = false),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Orders',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          OrdersSearchBar(
            onChanged: (value) => setState(() => searchQuery = value),
          ),

          const SizedBox(height: 12),

          const AppliedFiltersBar(),

          const SizedBox(height: 20),

          RevealOnScroll(
            child: OrdersTable(
              onRowTap: () => setState(() => showDrawer = true),
            ),
          ),

          const SizedBox(height: 20),

          OrdersPagination(
            currentPage: currentPage,
            totalPages: 5,
            onPageChanged: (page) => setState(() => currentPage = page),
          ),
        ],
      ),
    );
  }
}
