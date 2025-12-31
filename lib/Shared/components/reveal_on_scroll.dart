import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final double offset;
  final Duration duration;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.offset = 40,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('reveal_${identityHashCode(widget.child)}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.05 && !_hasAnimated) {
          if (mounted) {
            _hasAnimated = true;
            _controller.forward();
          }
        }
      },
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
