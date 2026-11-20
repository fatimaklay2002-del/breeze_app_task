import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import 'rating_summary_card.dart';
import 'review_card.dart';
import 'section_card.dart';

class ReviewsSection extends StatelessWidget {
  final Product product;
  const ReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final p = product;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle('Customer Reviews', trailing: '${p.reviews.length} verified'),
      if (p.reviews.isEmpty)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('No reviews yet.',
              style: TextStyle(color: AppColors.textSecondary)),
        )
      else ...[
        RatingSummaryCard(summary: p.ratingSummary),
        for (final r in p.reviews) ReviewCard(review: r),
      ],
    ]);
  }
}
