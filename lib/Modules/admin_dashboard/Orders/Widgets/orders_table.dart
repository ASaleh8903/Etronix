import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/hover_row.dart';
import 'package:etronix/Modules/admin_dashboard/Orders/Widgets/order_status_chip.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class OrdersTable extends StatelessWidget {
  final VoidCallback onRowTap;

  OrdersTable({super.key, required this.onRowTap});

  final orders = List.generate(8, (index) {
    return {
      'id': '#ORD-10$index',
      'customer': 'Ahmed Saleh',
      'date': 'Aug 20, 2025',
      'price': '\$120',
      'status': index.isEven ? 'Completed' : 'Pending',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _tableHeader(),
          const Divider(),
          ...orders.map(_tableRow).toList(),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return _row(
      bold: true,
      id: 'Order ID',
      customer: 'Customer',
      date: 'Date',
      price: 'Price',
      status: 'Status',
    );
  }

  Widget _tableRow(Map order) {
    return HoverRow(
      onTap: onRowTap,
      child: _row(
        id: order['id'],
        customer: order['customer'],
        date: order['date'],
        price: order['price'],
        statusWidget: OrderStatusChip(status: order['status']),
      ),
    );
  }

  Widget _row({
    bool bold = false,
    String? id,
    String? customer,
    String? date,
    String? price,
    String? status,
    Widget? statusWidget,
  }) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
      color: AppColors.textPrimary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          _cell(id!, style),
          _cell(customer!, style),
          _cell(date!, style),
          _cell(price!, style),
          Expanded(child: statusWidget ?? Text(status!, style: style)),
        ],
      ),
    );
  }

  Widget _cell(String text, TextStyle style) {
    return Expanded(child: Text(text, style: style));
  }
}
