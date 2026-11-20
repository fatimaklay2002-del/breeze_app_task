import 'package:flutter/material.dart';

import '../product_card/product_card_skeleton.dart';

class ProductsLoading extends StatelessWidget {
  final int count;
  final double topPadding;

  const ProductsLoading({super.key, this.count = 5, this.topPadding = 0});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(16, topPadding, 16, 0),
      sliver: SliverList.separated(
        itemCount: count,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => const ProductCardSkeleton(),
      ),
    );
  }
}
