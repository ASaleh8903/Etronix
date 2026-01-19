import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(String) onSelect;

  const CategoriesBar({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategories.contains(category);

          return CategoryItem(
            title: category,
            isSelected: isSelected,
            onTap: () => onSelect(category),
          );
        },
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
                : (isHovered ? AppColors.primary.withOpacity(0.1) : AppColors.card),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected || isHovered ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : (isHovered ? AppColors.primary : AppColors.textPrimary),
              fontWeight: widget.isSelected || isHovered ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}