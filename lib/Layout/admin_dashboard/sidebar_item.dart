import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:flutter/material.dart';
import '../../Shared/styles/colors.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;
  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.activeColor,
    required int index,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.activeColor ?? Colors.white;
    final color = widget.isActive || isHover ? defaultColor : Colors.white70;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            decoration: BoxDecoration(
              color: widget.isActive
                  ? (widget.activeColor?.withOpacity(0.1) ??
                        Colors.white.withOpacity(0.1))
                  : (isHover
                        ? (widget.activeColor?.withOpacity(0.05) ??
                              Colors.white.withOpacity(0.05))
                        : Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 4,
                  height: widget.isActive ? 25 : 0,
                  decoration: BoxDecoration(
                    color: widget.activeColor ?? Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedPadding(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.only(
                    left: isHover && !widget.isActive ? 5 : 0,
                  ),
                  child: Icon(widget.icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: widget.isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
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
