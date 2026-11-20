import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import 'product_info_chip.dart';
import 'product_pricing_card.dart';
import 'product_tags.dart';

class ProductHeader extends StatelessWidget {
  final Product product;
  final VoidCallback onReviewsTap;
  const ProductHeader({
    super.key,
    required this.product,
    required this.onReviewsTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = product;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          if (p.hasBrand)
            Text(p.brand!.toUpperCase(),
                style: text.labelMedium?.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('SKU: ${p.sku}',
              style:
                  text.labelMedium?.copyWith(color: AppColors.textSecondary)),
        ]),
        const SizedBox(height: 6),
        Text(p.title,
            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 6,
          children: [
            ProductInfoChip(
              bg: AppColors.chipBg,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.star_rounded, size: 16, color: AppColors.star),
                const SizedBox(width: 4),
                Text(p.rating.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ]),
            ),
            InkWell(
              onTap: onReviewsTap,
              child: Text('${p.reviews.length} Verified Reviews ->',
                  style: const TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600)),
            ),
            ProductInfoChip(
              bg: AppColors.successBg,
              child: Text('${p.stock} in stock',
                  style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
            ),
          ],
        ),
        if (p.tags.isNotEmpty) ...[
          const SizedBox(height: 12),
          ProductTags(tags: p.tags),
        ],
        const SizedBox(height: 16),
        PricingCard(product: p),
      ]),
    );
  }
}
