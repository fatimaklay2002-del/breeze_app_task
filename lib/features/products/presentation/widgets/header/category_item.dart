import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/category_style.dart';
import '../../../data/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool selected;
  final VoidCallback onTap;
  const CategoryItem({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = categoryStyleFor(category.slug);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 68,
        child: Column(children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? style.color.withValues(alpha: 0.10)
                  : Colors.white,
              border: Border.all(
                color: selected ? style.color : AppColors.border,
                width: selected ? 2 : 1,
              ),
            ),
            child: Icon(style.icon, size: 22, color: style.color),
          ),
          const SizedBox(height: 6),
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.textBody,
            ),
          ),
        ]),
      ),
    );
  }
}
