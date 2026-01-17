import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterMainList extends StatelessWidget {
  const FilterMainList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        return SizedBox(
          width: 180,
          child: Column(
            children: [
              FilterCategoryItem(
                title: 'Date',
                category: OrderFilterCategory.date,

                cubit: cubit,
              ),
              FilterCategoryItem(
                title: 'Payment',
                category: OrderFilterCategory.payment,

                cubit: cubit,
              ),
              FilterCategoryItem(
                title: 'Status',
                category: OrderFilterCategory.status,

                cubit: cubit,
              ),
              FilterCategoryItem(
                title: 'Category',
                category: OrderFilterCategory.products,

                cubit: cubit,
              ),
            ],
          ),
        );
      },
    );
  }
}

class FilterCategoryItem extends StatefulWidget {
  final String title;
  final OrderFilterCategory category;
  final Color activeColor = AppColors.primary;
  final AdminDashboardCubit cubit;

  const FilterCategoryItem({
    super.key,
    required this.title,
    required this.category,
    required this.cubit,
  });

  @override
  State<FilterCategoryItem> createState() => _FilterCategoryItemState();
}

class _FilterCategoryItemState extends State<FilterCategoryItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.cubit.activeFilterCategory == widget.category;
    final color = isActive || isHover ? widget.activeColor : Colors.black87;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        onTap: () => widget.cubit.selectFilterCategory(widget.category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? widget.activeColor.withOpacity(0.1)
                : (isHover
                      ? widget.activeColor.withOpacity(0.05)
                      : Colors.transparent),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 4,
                height: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: widget.activeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              if (isActive) const SizedBox(width: 8),
              Icon(Icons.chevron_left, size: 18, color: color),
              const Spacer(),
              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(right: isHover && !isActive ? 5 : 0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
