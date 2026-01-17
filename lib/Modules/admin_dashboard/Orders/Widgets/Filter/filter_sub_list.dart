import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSubList extends StatelessWidget {
  const FilterSubList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);
        final category = cubit.activeFilterCategory;

        if (category == null) return const SizedBox.shrink();

        List<String> options = [];
        Color themeColor = Colors.blueAccent;
        dynamic currentSelection;
        void Function(String) onSelect;

        switch (category) {
          case OrderFilterCategory.date:
            options = [
              'Today',
              'Yesterday',
              'Last 7 Days',
              'Last 30 Days',
              'Custom Range',
            ];
            themeColor = Colors.blueAccent;
            currentSelection = cubit.dateFilter;
            onSelect = (val) => cubit.setDateFilter(val);
            break;
          case OrderFilterCategory.payment:
            options = [
              'Cash on Delivery',
              'Credit Card',
              'Wallet',
              'Bank Transfer',
            ];
            themeColor = Colors.orangeAccent;
            currentSelection = cubit.paymentMethod;
            onSelect = (val) => cubit.setPaymentMethod(val);
            break;
          case OrderFilterCategory.status:
            options = [
              'Pending',
              'Processing',
              'Shipped',
              'Delivered',
              'Cancelled',
            ];
            themeColor = Colors.greenAccent;
            currentSelection = cubit.orderStatus;
            onSelect = (val) => cubit.setOrderStatus(val);
            break;
          case OrderFilterCategory.products:
            options = [
              'Phones',
              'Tablets',
              'Laptops',
              'Monitors',
              'Headphones',
              'Speakers',
              'Cameras',
              'Smart Watches',
              'Accessories',
            ];
            themeColor = Colors.purpleAccent;
            currentSelection = cubit.selectedProducts;
            onSelect = (val) => cubit.toggleProduct(val);
            break;
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            final bool isSelected = (currentSelection is List)
                ? currentSelection.contains(option)
                : currentSelection == option;

            return SubFilterItem(
              title: option,
              isSelected: isSelected,
              activeColor: themeColor,
              onTap: () => onSelect(option),
              isCheckbox: category == OrderFilterCategory.products,
            );
          },
        );
      },
    );
  }
}

class SubFilterItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;
  final bool isCheckbox;

  const SubFilterItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
    this.isCheckbox = false,
  });

  @override
  State<SubFilterItem> createState() => _SubFilterItemState();
}

class _SubFilterItemState extends State<SubFilterItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isSelected || isHover
        ? widget.activeColor
        : Colors.black87;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.activeColor.withOpacity(0.1)
                : (isHover
                      ? widget.activeColor.withOpacity(0.05)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (widget.isCheckbox)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? widget.activeColor
                        : Colors.transparent,
                    border: Border.all(
                      color: widget.isSelected
                          ? widget.activeColor
                          : Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: widget.isSelected
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                )
              else
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? widget.activeColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.isSelected
                          ? widget.activeColor
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.only(
                    left: isHover && !widget.isSelected ? 5 : 0,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: widget.isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
              if (widget.isSelected && !widget.isCheckbox)
                Icon(Icons.check_circle, size: 16, color: widget.activeColor),
            ],
          ),
        ),
      ),
    );
  }
}
