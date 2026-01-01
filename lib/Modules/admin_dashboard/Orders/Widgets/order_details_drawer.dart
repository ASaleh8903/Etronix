import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailsDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const OrderDetailsDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      top: 0,
      bottom: 0,
      right: isOpen ? 0 : -420,
      width: width < 1100 ? width : 420,
      child: Material(
        elevation: 20,
        color: Colors.white,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Order Info'),
                    _infoRow('Order ID', '#ORD-1289'),
                    _infoRow('Date', '12 Aug 2025'),
                    _infoRow('Item ID', '22480'),
                    _infoRow('Payment', 'Credit Card'),
                    _infoRow('Coupon Code', 'AHMED123'),

                    const SizedBox(height: 15),
                    _sectionTitle('Customer'),
                    _infoRow('Name', 'Ahmed Saleh'),
                    _infoRow('Email', 'ahmed@email.com'),
                    _infoRow('Phone', '+201020556872'),
                    _infoRow('Address', 'Damietta, Egypt'),

                    const SizedBox(height: 15),
                    _sectionTitle('Status'),
                    _statusChip('Shipped'),

                    const SizedBox(height: 15),
                    _sectionTitle('Salary'),
                    _infoRow('Price', '4250 EGP'),
                    _infoRow('Delivery', '50 EGP'),
                    _infoRow('Coupon', '- 50 EGP'),
                    Container(
                      width: double.infinity,
                      color: Colors.grey,
                      height: 1,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          'EGP 4,250',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Widgets =================

  Widget _header() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onClose),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;

    switch (status) {
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Shipped':
        color = Colors.blue;
        break;
      case 'Completed':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}
