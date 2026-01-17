import 'package:etronix/Modules/admin_dashboard/Products/Widgests/product_details_drawer.dart';
import 'package:etronix/Shared/components/hover_animation.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Shared/styles/colors.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const categories = [
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardStates>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 20),
                  Center(child: _categories(cubit)),
                  const SizedBox(height: 24),
                  Expanded(child: _productsGrid(cubit)),
                ],
              ),
            ),
            const ProductDetailsDrawer(),
          ],
        );
      },
    );
  }

  Widget _header() {
    return Text(
      'Products',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _categories(AdminDashboardCubit cubit) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = cubit.selectedProducts.contains(category);

          return GestureDetector(
            onTap: () => cubit.toggleProduct(category),
            child: SimpleHoverItem(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.card,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isActive ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productsGrid(AdminDashboardCubit cubit) {
    final List<Map<String, dynamic>> products = List.generate(12, (index) {
      return {
        'name': 'Product ${index + 1}',
        'price': '\$${(index + 1) * 120}',
      };
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 900
            ? 3
            : 2;

        return GridView.builder(
          padding: const EdgeInsets.only(bottom: 40),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return RevealOnScroll(
              child: _productCard(products[index], context),
            );
          },
        );
      },
    );
  }

  Widget _productCard(Map<String, dynamic> product, BuildContext context) {
    final cubit = AdminDashboardCubit.get(context);

    return SimpleHoverItem(
      child: GestureDetector(
        onTap: () => cubit.openProductDrawer(product),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(child: Icon(Icons.devices, size: 48)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product['price'],
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
