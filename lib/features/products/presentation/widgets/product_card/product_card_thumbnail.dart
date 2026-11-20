import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../data/models/product.dart';
import 'product_card_pill.dart';
import 'package:flutter/material.dart';

class ProductCardThumbnail extends StatelessWidget {
  final Product product;
  const ProductCardThumbnail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      height: 94,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppNetworkImage(url: product.thumbnail, cacheWidth: 300),
          ),
          if (product.hasDiscount)
            Positioned(
              top: 6,
              left: 6,
              child: ProductCardPill(
                text: '-${product.discountRounded}%',
                bg: AppColors.discount,
                fg: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}