import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'product_info_chip.dart';

/// "#tag" chips.
class ProductTags extends StatelessWidget {
  final List<String> tags;
  const ProductTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: [
      for (final t in tags)
        ProductInfoChip(
          bg: AppColors.primaryLight,
          child: Text('#$t',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ),
    ]);
  }
}
