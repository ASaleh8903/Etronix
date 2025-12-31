import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/best_products.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/dashboard_card.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/low_stock_card.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/order_status_card.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/quick_actions.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/recent_orders.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/sales_chart.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/system_notifications.dart';
import 'package:etronix/Modules/admin_dashboard/Dashboard/Widgets/activity_panel.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2.2,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              RevealOnScroll(
                child: DashboardCard(
                  title: 'Sales',
                  value: '\$24,500',
                  icon: Icons.attach_money,
                ),
              ),
              RevealOnScroll(
                child: DashboardCard(
                  title: 'Orders',
                  value: '1,240',
                  icon: Icons.shopping_cart,
                ),
              ),
              RevealOnScroll(
                child: DashboardCard(
                  title: 'Users',
                  value: '820',
                  icon: Icons.people,
                ),
              ),
              RevealOnScroll(
                child: DashboardCard(
                  title: 'Revenue',
                  value: '\$12,300',
                  icon: Icons.trending_up,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          SizedBox(
            height: 320,
            child: Row(
              children: const [
                Expanded(flex: 2, child: RevealOnScroll(child: SalesChart())),
                SizedBox(width: 20),
                Expanded(child: RevealOnScroll(child: ActivityPanel())),
              ],
            ),
          ),

          const SizedBox(height: 24),
          SizedBox(
            height: 250,
            child: Row(
              children: const [
                Expanded(child: RevealOnScroll(child: OrderStatusCard())),
                SizedBox(width: 20),
                Expanded(child: RevealOnScroll(child: LowStockCard())),
              ],
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 250,
            child: Row(
              children: const [
                const SizedBox(
                  height: 350,
                  child: RevealOnScroll(child: RecentOrders()),
                ),
                SizedBox(width: 20),
                Expanded(child: RevealOnScroll(child: BestProducts())),
                SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 240,
            child: Row(
              children: const [
                Expanded(child: RevealOnScroll(child: SystemNotifications())),
                SizedBox(width: 20),
                Expanded(child: RevealOnScroll(child: QuickActions())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
