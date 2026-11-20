import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import 'product_info_chip.dart';

/// "18% OFF" + "BEAUTY CHOICE" badges.
class GalleryBadges extends StatelessWidget {
  final Product product;
  const GalleryBadges({super.key, required this.product});

  Widget _badge(String text, Color bg, Color fg) => ProductInfoChip(
        bg: bg,
        child: Text(text,
            style:
                TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: fg)),
      );

  @override
  Widget build(BuildContext context) => Row(children: [
        if (product.hasDiscount)
          _badge('${product.discountRounded}% OFF', AppColors.discount,
              Colors.white),
        const SizedBox(width: 6),
        _badge('${product.categoryLabel.toUpperCase()} CHOICE', Colors.white,
            AppColors.primary),
      ]);
}

class GalleryDots extends StatelessWidget {
  final int count, current;
  const GalleryDots({super.key, required this.count, required this.current});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == current ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: i == current ? AppColors.primary : Colors.white70,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      );
}
