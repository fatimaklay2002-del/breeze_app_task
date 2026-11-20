
import 'package:flutter/material.dart';

class ProductCardPill extends StatelessWidget {
  final String text;
  final Color bg, fg;
  final IconData? icon;
  const ProductCardPill(
      {super.key, required this.text, required this.bg, required this.fg, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 3)
        ],
        Text(text,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
      ]),
    );
  }
}
