import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../data/models/product.dart';
import 'add_button.dart';

/// Price (+ strikethrough original), Details link and the Add button.
class ProductCardFooter extends StatelessWidget {
  final Product product;
  final VoidCallback onDetails;
  const ProductCardFooter({
    super.key,
    required this.product,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final p = product;
    return Row(children: [
      Expanded(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(formatPrice(p.price),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary)),
            if (p.hasDiscount) ...[
              const SizedBox(width: 6),
              Text(formatPrice(p.originalPrice),
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                      decoration: TextDecoration.lineThrough)),
            ],
          ]),
        ),
      ),
      const SizedBox(width: 8),
      InkWell(
        onTap: onDetails,
        borderRadius: BorderRadius.circular(8),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Details',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary)),
            Icon(Icons.chevron_right_rounded,
                size: 18, color: AppColors.primary),
          ]),
        ),
      ),
      const SizedBox(width: 8),
      AddButton(product: p),
    ]);
  }
}
