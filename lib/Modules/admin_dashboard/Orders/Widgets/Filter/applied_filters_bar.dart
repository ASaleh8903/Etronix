import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Shared/styles/colors.dart';

class AppliedFiltersBar extends StatelessWidget {
  const AppliedFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);
        final List<Widget> chips = [];

        if (cubit.dateFilter != null) chips.add(_buildChip(context, 'Date: ${cubit.dateFilter}', 'date'));
        if (cubit.paymentMethod != null) chips.add(_buildChip(context, 'Payment: ${cubit.paymentMethod}', 'payment'));
        if (cubit.orderStatus != null) chips.add(_buildChip(context, 'Status: ${cubit.orderStatus}', 'status'));
        if (cubit.selectedProducts.isNotEmpty) {
           chips.add(_buildChip(context, 'Products: ${cubit.selectedProducts.length}', 'products'));
        }

        if (chips.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...chips,
              TextButton(
                onPressed: () => cubit.clearAllFilters(),
                child: const Text('Clear All', style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChip(BuildContext context, String label, String key) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      deleteIcon: const Icon(Icons.close, size: 14),
      onDeleted: () => AdminDashboardCubit.get(context).removeFilter(key),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}