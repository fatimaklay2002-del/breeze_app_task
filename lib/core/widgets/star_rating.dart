import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final int stars;
  final double size;
  const StarRating({super.key, required this.stars, this.size = 16});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= 5; i++)
            Icon(i <= stars ? Icons.star_rounded : Icons.star_outline_rounded,
                size: size, color: AppColors.star),
        ],
      );
}
