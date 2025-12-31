import 'package:flutter/material.dart';
import 'hover_card.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Recent Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Total')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('#1023')),
                  DataCell(Text('Ahmed')),
                  DataCell(Text('Completed')),
                  DataCell(Text('\$120')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('#1024')),
                  DataCell(Text('Mohamed')),
                  DataCell(Text('Pending')),
                  DataCell(Text('\$75')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
