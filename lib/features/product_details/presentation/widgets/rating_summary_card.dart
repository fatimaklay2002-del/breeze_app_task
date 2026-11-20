import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/star_rating.dart';
import '../../../products/data/models/rating_summary.dart';
import 'section_card.dart';

/// Average rating + 5★..1★ distribution (all numbers come from RatingSummary).
class RatingSummaryCard extends StatelessWidget {
  final RatingSummary summary;
  const RatingSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(children: [
        Column(children: [
          Text(summary.averageLabel,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
          StarRating(stars: summary.filledStars, size: 16),
          const SizedBox(height: 4),
          const Text('out of 5',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ]),
        const SizedBox(width: 20),
        Expanded(
          child: Column(children: [
            for (final bar in summary.bars) _BarRow(bar: bar),
          ]),
        ),
      ]),
    );
  }
}

class _BarRow extends StatelessWidget {
  final RatingBar bar;
  const _BarRow({required this.bar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        SizedBox(
            width: 24,
            child: Text('${bar.stars}★', style: const TextStyle(fontSize: 12))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: bar.fraction,
              minHeight: 7,
              backgroundColor: AppColors.primaryLight,
              color: bar.stars <= 1 ? AppColors.discount : AppColors.primary,
            ),
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(bar.label,
              textAlign: TextAlign.end, style: const TextStyle(fontSize: 12)),
        ),
      ]),
    );
  }
}
