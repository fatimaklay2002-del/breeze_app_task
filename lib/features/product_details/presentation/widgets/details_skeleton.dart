import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_box.dart';

class DetailsSkeleton extends StatelessWidget {
  const DetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: ShimmerWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AspectRatio(
              aspectRatio: 1,
              child: ShimmerBox(radius: 24),
            ),
            const SizedBox(height: 16),
            const Row(children: [
              ShimmerBox(width: 90, height: 12),
              Spacer(),
              ShimmerBox(width: 110, height: 12),
            ]),
            const SizedBox(height: 12),
            const ShimmerBox(height: 28),
            const SizedBox(height: 12),
            const Row(children: [
              ShimmerBox(width: 64, height: 26, radius: 13),
              SizedBox(width: 10),
              ShimmerBox(width: 110, height: 14),
              SizedBox(width: 10),
              ShimmerBox(width: 80, height: 22, radius: 11),
            ]),
            const SizedBox(height: 16),
            const ShimmerBox(height: 110, radius: 16),
            const SizedBox(height: 16),
            Row(children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                const Expanded(child: ShimmerBox(height: 64, radius: 12)),
              ],
            ]),
            const SizedBox(height: 10),
            Row(children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                const Expanded(child: ShimmerBox(height: 64, radius: 12)),
              ],
            ]),
            const SizedBox(height: 24),
            const ShimmerBox(width: 130, height: 20),
            const SizedBox(height: 12),
            const ShimmerBox(height: 90, radius: 16),
            const SizedBox(height: 24),
            const ShimmerBox(width: 160, height: 20),
            const SizedBox(height: 12),
            const ShimmerBox(height: 120, radius: 16),
          ],
        ),
      ),
    );
  }
}
