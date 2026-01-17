import 'package:etronix/Layout/admin_dashboard/Cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'orders_filter_panel.dart';

class OrdersFilterButton extends StatefulWidget {
  const OrdersFilterButton({super.key});

  @override
  State<OrdersFilterButton> createState() => _OrdersFilterButtonState();
}

class _OrdersFilterButtonState extends State<OrdersFilterButton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _controller.forward();
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _hideOverlay,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            offset: const Offset(0, 8),
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _controller,
                child: const OrdersFilterPanel(),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _controller.reverse().then((value) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      AdminDashboardCubit.get(context).resetCategoryOnly();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          onPressed: _showOverlay,
          icon: const Icon(Icons.filter_list, size: 20),
          label: const Text('Filters'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}