// import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/order_details_drawer.dart';
// import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/orders_pagination.dart';
// import 'package:etronix/Shared/components/reveal_on_scroll.dart';
// import 'package:flutter/material.dart';
// import 'widgets/orders_header.dart';
// import 'widgets/orders_table.dart';

// class OrdersScreen extends StatefulWidget {

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   int currentPage = 1;

//   bool showDrawer = false;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RevealOnScroll(child: OrdersHeader()),
//           const SizedBox(height: 24),
//           RevealOnScroll(child: OrdersTable()),
//           RevealOnScroll(
//             child: OrdersPagination(
//               currentPage: currentPage,
//               totalPages: 5,
//               onPageChanged: (page) {
//                 currentPage = page;
//                 page++;
//               },
//             ),
//           ),
//           Stack(
//     children: [
//     OrdersTable(
//       onRowTap: () {
//         setState(() => showDrawer = true);
//       },
//     ),

//     OrderDetailsDrawer(
//       isOpen: showDrawer,
//       onClose: () => setState(() => showDrawer = false),
//     ),
//   ],
// )
//         ],
//       ),
//     );
//   }
// }

import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/order_search.dart';
import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/orders_pagination.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'widgets/orders_table.dart';
import 'widgets/order_details_drawer.dart';

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
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Title =====
              const Text(
                'Orders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // ===== Search =====
              OrdersSearchBar(
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
              ),

              const SizedBox(height: 20),

              // ===== Table =====
              RevealOnScroll(
                child: OrdersTable(
                  onRowTap: () {
                    setState(() => showDrawer = true);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ===== Pagination =====
              OrdersPagination(
                currentPage: currentPage,
                totalPages: 5,
                onPageChanged: (page) {
                  setState(() => currentPage = page);
                },
              ),
            ],
          ),
        ),

        // ===== Backdrop =====
        if (showDrawer)
          GestureDetector(
            onTap: () => setState(() => showDrawer = false),
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),

        // ===== Drawer =====
        OrderDetailsDrawer(
          isOpen: showDrawer,
          onClose: () => setState(() => showDrawer = false),
        ),
      ],
    );
  }
}
