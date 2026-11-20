import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/category_style.dart';
import '../../../data/models/category.dart';

class CategoryGridTile extends StatelessWidget {
  final Category category;
  final bool selected;
  final VoidCallback onTap;
  const CategoryGridTile({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = categoryStyleFor(category.slug);
    final radius = BorderRadius.circular(14);
    return Material(
      color: selected ? style.color.withValues(alpha: 0.10) : AppColors.subtle,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: selected ? style.color : AppColors.border),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(style.icon, size: 28, color: style.color),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
