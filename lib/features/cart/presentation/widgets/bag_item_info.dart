import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../data/cart_item.dart';

/// Brand, title, unit price and line total of a bag row.
class BagItemInfo extends StatelessWidget {
  final CartItem item;
  const BagItemInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    final text = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (p.hasBrand)
        Text(p.brand!.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text.labelSmall?.copyWith(color: AppColors.textSecondary)),
      Text(p.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: text.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text('${formatPrice(p.price)} each',
          style: text.bodySmall?.copyWith(color: AppColors.textSecondary)),
      const SizedBox(height: 8),
      Text(formatPrice(item.total),
          style: text.titleMedium?.copyWith(
              fontWeight: FontWeight.w800, color: AppColors.primary)),
    ]);
  }
}
