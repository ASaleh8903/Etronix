import 'package:flutter/material.dart';

class SimpleHoverItem extends StatefulWidget {
  final Widget child;
  const SimpleHoverItem({super.key, required this.child});

  @override
  State<SimpleHoverItem> createState() => _SimpleHoverItemState();
}

class _SimpleHoverItemState extends State<SimpleHoverItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
           transform: isHovered 
            ? Matrix4.translationValues(0, -3, 0) 
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.12 : 0.05),
              blurRadius: isHovered ? 12 : 6,
              offset: Offset(0, isHovered ? 6 : 3),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}