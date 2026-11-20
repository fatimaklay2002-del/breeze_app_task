import '../../../../../core/theme/app_decorations.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/shimmer_box.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: AppDecorations.card(),
      child: const ShimmerWrap(
        child: Column(
          children: [
            SizedBox(
              height: 104,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 94, height: 94),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 72, height: 10),
                        SizedBox(height: 8),
                        ShimmerBox(height: 16),
                        SizedBox(height: 10),
                        Row(children: [
                          ShimmerBox(width: 52, height: 14),
                          SizedBox(width: 8),
                          ShimmerBox(width: 78, height: 18, radius: 9),
                        ]),
                        SizedBox(height: 10),
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ShimmerBox(height: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 11),
            ShimmerBox(height: 1, radius: 0),
            SizedBox(height: 10),
            Row(
              children: [
                ShimmerBox(width: 84, height: 28, radius: 14),
                Spacer(),
                ShimmerBox(width: 56, height: 20, radius: 10),
                SizedBox(width: 8),
                ShimmerBox(width: 96, height: 40, radius: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
