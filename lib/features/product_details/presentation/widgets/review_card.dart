import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/star_rating.dart';
import '../../../products/data/models/review.dart';
import 'section_card.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final r = review;
    return SectionCard(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryLight,
            child: Text(r.initials,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.reviewerName,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              if (r.date != null)
                Text(r.dateLabel,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
            ]),
          ),
          StarRating(stars: r.rating, size: 15),
        ]),
        const SizedBox(height: 10),
        Text('"${r.comment}"', style: const TextStyle(height: 1.4)),
        const SizedBox(height: 8),
        const Row(children: [
          Icon(Icons.verified_rounded, size: 14, color: AppColors.success),
          SizedBox(width: 4),
          Text('Verified Buyer',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success)),
        ]),
      ]),
    );
  }
}
