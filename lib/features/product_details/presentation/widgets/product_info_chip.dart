import 'package:flutter/material.dart';

/// Pill used for rating, stock, tags, badges (Figma: padding 10x4, radius 9999).
class ProductInfoChip extends StatelessWidget {
  final Widget child;
  final Color bg;
  const ProductInfoChip({super.key, required this.child, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: child,
    );
  }
}
