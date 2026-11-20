import 'package:flutter/material.dart';
import '../../../../../app/navigation/app_navigator.dart';
import '../../../data/models/product.dart';
import '../product_card/product_card.dart';

class ProductsSliverList extends StatelessWidget {
  final List<Product> products;
  const ProductsSliverList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) => ProductCard(
          product: products[i],
          onDetails: () => openProductDetails(context, products[i]),
        ),
      ),
    );
  }
}
