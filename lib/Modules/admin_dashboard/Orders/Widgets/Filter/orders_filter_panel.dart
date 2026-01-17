import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_main_list.dart';
import 'filter_sub_list.dart';

class OrdersFilterPanel extends StatelessWidget {
  const OrdersFilterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);
        final bool hasSelection = cubit.activeFilterCategory != null;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: hasSelection ? 520 : 185,
          height: 280,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(blurRadius: 15, color: Colors.black.withOpacity(.1)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasSelection) ...[
                Expanded(
                  child: FilterSubList(
                    key: ValueKey(cubit.activeFilterCategory),
                  ),
                ),
                const VerticalDivider(width: 1, thickness: 1),
              ],
              const FilterMainList(),
            ],
          ),
        );
      },
    );
  }
}
