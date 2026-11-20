import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import 'section_card.dart';

class SpecsSection extends StatelessWidget {
  final Product product;
  const SpecsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final p = product;
    final rows = [
      ('Weight', p.weightLabel),
      ('Dimensions', p.dimensions.formatted),
      ('Barcode', p.meta.barcode),
      ('Category', p.categoryLabel),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Specifications'),
      SectionCard(
        padding: EdgeInsets.zero,
        child: Column(children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(children: [
                Text(rows[i].$1,
                    style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(rows[i].$2,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ]),
            ),
          ],
        ]),
      ),
    ]);
  }
}
