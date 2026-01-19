import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Modules/admin_dashboard/Products/Widgests/add_edit_product_screen.dart';
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
            GestureDetector(
              onTap: cubit.closeProductDrawer,
              child: Container(color: Colors.black.withOpacity(0.35)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 1, end: 0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(360 * value, 0),
                    child: child,
                  );
                },
                child: _drawerContent(context, cubit),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _drawerContent(BuildContext context, AdminDashboardCubit cubit) {
    final product = cubit.selectedProduct!;

    return Container(
      width: 360,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Product Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(child: Icon(Icons.devices, size: 64)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['price'].toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['description'] ??
                          'High quality product with modern specifications suitable for daily use.',
                      style: TextStyle(color: Colors.grey[600], height: 1.5),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          (product['categories'] as List? ??
                                  ['Phones', 'Tablets', 'Laptops'])
                              .map((e) => Chip(label: Text(e.toString())))
                              .toList(),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Support',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSupportRow(
                      'Return period',
                      '${product['returnDays'] ?? 14} day(s)',
                    ),
                    _buildSupportRow(
                      'Warranty period',
                      '${product['warrantyMonths'] ?? 1} Year(s)',
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Coupons',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['coupon'] ?? 'No Coupons Available',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: defaultButton(
                  context: context,
                  function: () {
                    cubit.isProductDialogEdit = true;
                    showDialog(
                      context: context,
                      builder: (context) => const AddEditProductDialog(),
                    );
                  },
                  text: 'Edit Product',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          const Spacer(),
          Text(value, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget defaultButton({
    required BuildContext context,
    double? width,
    double height = 50,
    bool isUpperCase = true,
    double radius = 12,
    required VoidCallback function,
    required String text,
  }) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
