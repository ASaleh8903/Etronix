import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/cubit.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        return Container(
          width: 260,
          color: const Color(0xFF1E293B),
          child: Column(
            children: [
              const SizedBox(height: 28),
              const Text(
                'ETRONIX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 36),

              SidebarItem(Icons.dashboard, 'Dashboard', 0, cubit),
              SidebarItem(Icons.shopping_cart_outlined, 'Orders', 1, cubit),
              SidebarItem(Icons.inventory_2_outlined, 'Products', 2, cubit),
              SidebarItem(Icons.people_outline, 'Customers', 3, cubit),
              SidebarItem(Icons.bar_chart_outlined, 'Reports', 4, cubit),
              SidebarItem(Icons.settings_outlined, 'Settings', 5, cubit),
            ],
          ),
        );
      },
    );
  }
}

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final int index;
  final AdminDashboardCubit cubit;

  const SidebarItem(
    this.icon,
    this.title,
    this.index,
    this.cubit, {
    super.key,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.cubit.currentIndex == widget.index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => widget.cubit.changeIndex(widget.index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: 50,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white12
                  : isHover
                      ? Colors.white.withOpacity(0.06)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                // Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 5,
                  height: isActive ? 32 : 0,
                  decoration: BoxDecoration(
                    color:
                        isActive ? Colors.blueAccent : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(width: 14),

                AnimatedPadding(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.only(left: isHover ? 4 : 0),
                  child: Icon(
                    widget.icon,
                    color: isActive || isHover
                        ? Colors.white
                        : Colors.white70,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: isActive || isHover
                          ? Colors.white
                          : Colors.white70,
                      fontSize: 15,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                    child: Text(widget.title),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

