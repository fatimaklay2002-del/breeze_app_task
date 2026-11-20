import 'package:flutter/material.dart';
import '../../../products/data/models/product.dart';
import 'description_section.dart';
import 'image_gallery.dart';
import 'info_grid.dart';
import 'product_header.dart';
import 'reviews_section.dart';
import 'specs_section.dart';

class ProductDetailsBody extends StatelessWidget {
  final Product product;
  final Key reviewsKey;
  final VoidCallback onReviewsTap;
  const ProductDetailsBody({
    super.key,
    required this.product,
    required this.reviewsKey,
    required this.onReviewsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ImageGallery(product: product),
        ProductHeader(product: product, onReviewsTap: onReviewsTap),
        InfoGrid(product: product),
        DescriptionSection(product: product),
        SpecsSection(product: product),
        KeyedSubtree(key: reviewsKey, child: ReviewsSection(product: product)),
      ]),
    );
  }
}
