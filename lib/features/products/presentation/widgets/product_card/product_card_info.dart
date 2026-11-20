import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/product.dart';
import 'stock_badge.dart';
import 'wishlist_button.dart';
import 'package:flutter/material.dart';

class ProductCardInfo extends StatelessWidget {
  final Product product;
  const ProductCardInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final p = product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: p.hasBrand
                  ? Text(p.brand!.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: AppColors.textMuted))
                  : const SizedBox(height: 16),
            ),
            WishlistButton(product: p),
          ],
        ),
        Text(p.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 17,
                height: 1.2,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
              const SizedBox(width: 2),
              Text(p.rating.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              Text(' (${p.reviews.length})',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMuted)),
            ]),
            StockBadge(product: p),
          ],
        ),
        const SizedBox(height: 6),
        Row(children: [
          const Icon(Icons.local_shipping_outlined,
              size: 14, color: AppColors.success),
          const SizedBox(width: 4),
          Expanded(
            child: Text(p.shippingInformation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ),
        ]),
      ],
    );
  }
}