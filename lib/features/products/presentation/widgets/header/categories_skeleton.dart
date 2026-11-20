import 'package:flutter/material.dart';
import '../../../../../core/widgets/shimmer_box.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrap(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (_, _) => const SizedBox(
          width: 68,
          child: Column(children: [
            ShimmerBox(width: 52, height: 52, radius: 26),
            SizedBox(height: 8),
            ShimmerBox(width: 44, height: 10),
          ]),
        ),
      ),
    );
  }
}
