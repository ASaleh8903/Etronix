import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;

  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: isHover
            ? Matrix4.translationValues(0, -6, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: isHover ? 22 : 12,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(isHover ? 0.15 : 0.08),
            ),
          ],
        ),
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}
