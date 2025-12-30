import 'package:etronix/Layout/admin_dashboard/sidbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/styles/colors.dart';
import 'Cubit/cubit.dart';
import 'Cubit/states.dart';
import 'top_bar.dart';

class AdminLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminDashboardCubit, AdminDashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        return Row(
          children: [
            const AdminSidebar(),
            Expanded(
              child: Column(
                children: [
                  const TopBar(),
                  Expanded(child: cubit.sidbarScreens[cubit.currentIndex]),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
