import 'package:etronix/Shared/styles/colors.dart';
import 'package:flutter/material.dart';

class HoverRow extends StatefulWidget {
   final Widget child;
   final VoidCallback onTap;

   HoverRow({
    super.key,
    required this.child,
    required this.onTap,
  });
  

  @override
  State<HoverRow> createState() => _HoverRowState();
  
}

class _HoverRowState extends State<HoverRow> {
  
 

    bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: hovering
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: hovering ? Colors.grey[200] : AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
