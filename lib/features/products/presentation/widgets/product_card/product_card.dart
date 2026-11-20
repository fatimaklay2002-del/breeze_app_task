import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../data/models/product.dart';
import 'product_card_footer.dart';
import 'product_card_info.dart';
import 'product_card_thumbnail.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDetails;
  const ProductCard({
    super.key,
    required this.product,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: AppDecorations.card(),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProductCardThumbnail(product: product),
          const SizedBox(width: 12),
          Expanded(child: ProductCardInfo(product: product)),
        ]),
        const Divider(height: 22, color: AppColors.border),
        ProductCardFooter(product: product, onDetails: onDetails),
      ]),
    );
  }
}
