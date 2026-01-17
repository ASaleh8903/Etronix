import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Shared/styles/colors.dart';

class ProductDetailsDrawer extends StatelessWidget {
  const ProductDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        if (!cubit.isProductDrawerOpen || cubit.selectedProduct == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            /// Background fade
            GestureDetector(
              onTap: cubit.closeProductDrawer,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: 1,
                child: Container(color: Colors.black.withOpacity(0.35)),
              ),
            ),

            /// Drawer
            Align(
              alignment: Alignment.centerRight,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 1, end: 0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(350 * value, 0),
                    child: child,
                  );
                },
                child: _drawerContent(cubit),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _drawerContent(AdminDashboardCubit cubit) {
    final product = cubit.selectedProduct!;

    return Container(
      width: 360,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: cubit.closeProductDrawer,
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.devices, size: 64),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            product['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product['price'],
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'High quality product with modern specifications suitable for daily use.',
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Product'),
            ),
          ),
        ],
      ),
    );
  }
}
