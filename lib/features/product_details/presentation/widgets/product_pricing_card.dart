import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../products/data/models/product.dart';
import 'moq_notice.dart';
import 'product_info_chip.dart';

/// Current price, original price (strikethrough), savings badge and MOQ.
class PricingCard extends StatelessWidget {
  final Product product;
  const PricingCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final p = product;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 8,
          runSpacing: 8,
          children: [
            Text(formatPrice(p.price),
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
            if (p.hasDiscount) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(formatPrice(p.originalPrice),
                    style: const TextStyle(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough)),
              ),
              ProductInfoChip(
                bg: AppColors.discountBg,
                child: Text(
                  'Save ${formatPrice(p.savedAmount)} (${p.discountRounded}%)',
                  style: const TextStyle(
                      color: AppColors.discount,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        MoqNotice(product: p),
      ]),
    );
  }
}
