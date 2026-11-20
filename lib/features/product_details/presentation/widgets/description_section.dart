import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import 'section_card.dart';

class DescriptionSection extends StatelessWidget {
  final Product product;
  const DescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Description'),
          SectionCard(
            child: Text(product.description,
                style: const TextStyle(
                    height: 1.6, color: AppColors.textSecondary)),
          ),
        ],
      );
}
