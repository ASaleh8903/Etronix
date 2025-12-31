import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Layout/admin_dashboard/sidbar.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'top_bar.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                const AdminTopBar(),
                Expanded(
                  child: BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
                    builder: (context, state) {
                      final cubit = AdminDashboardCubit.get(context);
                      return TweenAnimationBuilder<double>(
                        key: ValueKey(cubit.currentIndex),
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: cubit.sidebarScreens[cubit.currentIndex],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
