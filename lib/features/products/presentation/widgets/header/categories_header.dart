import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

/// "TOP DEPARTMENTS" + "View All".
class CategoriesHeader extends StatelessWidget {
  final VoidCallback onViewAll;
  const CategoriesHeader({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        const Text(
          'TOP DEPARTMENTS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.textBody,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('View All',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.link,
              )),
        ),
      ]),
    );
  }
}
