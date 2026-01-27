import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Modules/admin_dashboard/Customers/Widgets/customer_details_screen.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/customer_card.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminDashboardCubit(),
      child: Builder(
        builder: (context) {
          final cubit = AdminDashboardCubit.get(context);

          return GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: cubit.customers.length,
            itemBuilder: (context, index) {
              return CustomerCard(
                customer: cubit.customers[index],
                onTap: () {
                  cubit.selectCustomer(cubit.customers[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RevealOnScroll(child: const CustomerDetailsScreen()),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
