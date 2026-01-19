import 'package:etronix/Modules/admin_dashboard/Products/Widgests/add_edit_product_screen.dart';
import 'package:etronix/Modules/admin_dashboard/Products/Widgests/product_details_drawer.dart';
import 'package:etronix/Shared/components/reveal_on_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Layout/admin_dashboard/Cubit/states.dart';
import 'package:etronix/Shared/styles/colors.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const allCategories = [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      _AddProductButton(
                        onTap: () {
                          cubit.isProductDialogEdit = false;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddEditProductDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  _buildCategoriesBar(cubit),

                  const SizedBox(height: 24),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 1400)
                          crossAxisCount = 5;
                        else if (constraints.maxWidth > 1100)
                          crossAxisCount = 4;
                        else if (constraints.maxWidth > 750)
                          crossAxisCount = 3;

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.82,
                              ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final product = {
                              'name': 'Product ${index + 1}',
                              'price': '\$${(index + 1) * 150}',
                            };
                            return RevealOnScroll(
                              child: ProductCardItem(product: product),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const ProductDetailsDrawer(),
          ],
        );
      },
    );
  }

  Widget _buildCategoriesBar(AdminDashboardCubit cubit) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = cubit.selectedProducts.contains(category);
          return CategoryItem(
            title: category,
            isSelected: isSelected,
            onTap: () => cubit.toggleProduct(category),
          );
        },
      ),
    );
  }
}

class _AddProductButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AddProductButton({required this.onTap});

  @override
  State<_AddProductButton> createState() => _AddProductButtonState();
}

class _AddProductButtonState extends State<_AddProductButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.primary : AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.1 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                size: 20,
                color: isHovered ? Colors.white : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Add Product',
                style: TextStyle(
                  color: isHovered ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const CategoryItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(25),
        hoverColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primary
                : (isHovered
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.card),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected || isHovered
                  ? AppColors.primary
                  : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.isSelected
                  ? Colors.white
                  : (isHovered ? AppColors.primary : AppColors.textPrimary),
              fontWeight: widget.isSelected || isHovered
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCardItem extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductCardItem({super.key, required this.product});

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final cubit = AdminDashboardCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => cubit.openProductDrawer(widget.product),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            transform: isHovered
                ? (Matrix4.identity()..translate(0, -8, 0))
                : Matrix4.identity(),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered ? AppColors.primary : AppColors.border,
                width: isHovered ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isHovered ? 0.08 : 0.04),
                  blurRadius: isHovered ? 20 : 10,
                  offset: Offset(0, isHovered ? 10 : 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isHovered
                          ? AppColors.primary.withOpacity(0.05)
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.devices,
                      size: 40,
                      color: isHovered ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.product['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHovered ? AppColors.primary : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.product['price'],
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
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
