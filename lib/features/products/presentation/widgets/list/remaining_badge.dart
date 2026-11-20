import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class RemainingBadge extends StatelessWidget {
  final int remaining;
  const RemainingBadge({super.key, required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.subtle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        '$remaining remaining',
        maxLines: 1,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
