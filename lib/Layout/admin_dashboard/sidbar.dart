import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/styles/colors.dart';
import 'sidebar_item.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        final List<Map<String, dynamic>> menuItems = [
          {'title': 'Dashboard', 'icon': Icons.dashboard},
          {'title': 'Orders', 'icon': Icons.shopping_cart},
          {'title': 'Products', 'icon': Icons.inventory},
          {'title': 'Customers', 'icon': Icons.people},
          {'title': 'Settings', 'icon': Icons.settings},
        ];

        return Container(
          width: 260,
          color: AppColors.sidebar,
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// Logo
              Text(
                'ETRONIX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return SidebarItem(
                      title: menuItems[index]['title'],
                      icon: menuItems[index]['icon'],
                      index: index,
                      isActive: cubit.currentIndex == index,
                      onTap: () => cubit.changeIndex(index),
                    );
                  },
                ),
              ),
              const Spacer(),
              SidebarItem(
                title: 'Logout',

                icon: Icons.logout_rounded,
                index: 99,
                isActive: false,
                activeColor: Colors.redAccent,
                onTap: () {
                  print("Logout Tapped");
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
