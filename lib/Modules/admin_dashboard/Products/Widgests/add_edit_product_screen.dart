import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:etronix/Models/admin_dashboard/product_model.dart';
import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditProductDialog extends StatefulWidget {
  final ProductModel? product;

  const AddEditProductDialog({super.key, this.product});

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final couponController = TextEditingController();

  List<TextEditingController> imageControllers = [TextEditingController()];

  final categoriesList = [
    'Phones',
    'Tablets',
    'Laptops',
    'Accessories',
    'Monitors',
  ];
  List<String> selectedCategories = [];

  int returnDays = 14;
  int warrantyMonths = 12;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final p = widget.product!;
      nameController.text = p.name;
      descController.text = p.description;
      selectedCategories = [...p.categories];
      if (p.imageUrls.isNotEmpty) {
        imageControllers = p.imageUrls
            .map((url) => TextEditingController(text: url))
            .toList();
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    quantityController.dispose();
    couponController.dispose();
    for (var controller in imageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 850,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Basic Information'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: nameController,
                      label: 'Product Name',
                      icon: Icons.shopping_bag_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: descController,
                      label: 'Description',
                      icon: Icons.description_outlined,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 24),
                    _buildSectionTitle('Pricing & Inventory'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: priceController,
                            label: 'Price (\$)',
                            icon: Icons.attach_money,
                            isNumber: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: quantityController,
                            label: 'Quantity Available',
                            icon: Icons.inventory_2_outlined,
                            isNumber: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: couponController,
                      label: 'Coupon Code (Optional)',
                      icon: Icons.local_offer_outlined,
                    ),

                    const SizedBox(height: 24),
                    _buildSectionTitle('Policy & Warranty'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown<int>(
                            value: returnDays,
                            label: 'Return Period',
                            icon: Icons.assignment_return_outlined,
                            items: [7, 14, 30, 60],
                            itemToString: (v) => '$v Days',
                            onChanged: (v) => setState(() => returnDays = v!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdown<int>(
                            value: warrantyMonths,
                            label: 'Warranty Period',
                            icon: Icons.verified_user_outlined,
                            items: [0, 6, 12, 24, 36],
                            itemToString: (v) => v == 0
                                ? 'No Warranty'
                                : (v >= 12
                                      ? '${v ~/ 12} Year(s)'
                                      : '$v Months'),
                            onChanged: (v) =>
                                setState(() => warrantyMonths = v!),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildSectionTitle('Categories'),
                    const SizedBox(height: 16),
                    _buildCustomCategoryBar(),

                    const SizedBox(height: 30),
                    _buildSectionTitle('Product Images'),
                    const SizedBox(height: 16),
                    _buildDynamicImageFields(),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicImageFields() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageControllers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: imageControllers[index],
                label: 'Image URL ${index + 1}',
                icon: Icons.link,
              ),
            ),
            const SizedBox(width: 10),
            if (index == imageControllers.length - 1)
              _buildActionButton(
                icon: Icons.add_circle,
                color: AppColors.primary,
                onTap: () => setState(
                  () => imageControllers.add(TextEditingController()),
                ),
              )
            else
              _buildActionButton(
                icon: Icons.remove_circle,
                color: Colors.redAccent,
                onTap: () {
                  setState(() {
                    imageControllers[index].dispose();
                    imageControllers.removeAt(index);
                  });
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required String label,
    required IconData icon,
    required List<T> items,
    required String Function(T) itemToString,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(itemToString(i))))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final cubit = AdminDashboardCubit.get(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cubit.isProductDialogEdit ? 'Edit Product' : 'Add Product',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final cubit = AdminDashboardCubit.get(context);
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.isProductDialogEdit = !cubit.isProductDialogEdit;
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.isProductDialogEdit = !cubit.isProductDialogEdit;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              cubit.isProductDialogEdit ? 'Save Changes' : 'Add Product',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 32),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  Widget _buildCustomCategoryBar() {
    return Container(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categoriesList[index];
          final isSelected = selectedCategories.contains(cat);
          return _CategoryItem(
            title: cat,
            isSelected: isSelected,
            onTap: () => setState(
              () => isSelected
                  ? selectedCategories.remove(cat)
                  : selectedCategories.add(cat),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const _CategoryItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<_CategoryItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(25),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
