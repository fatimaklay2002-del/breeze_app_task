import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/sort_option.dart';
import 'sort_dropdown.dart';

class StatusRow extends StatelessWidget {
  final int loaded, total;
  final SortOption? sort;
  final ValueChanged<SortOption?> onSortChanged;
  final VoidCallback onFilterTap;

  const StatusRow({
    super.key,
    required this.loaded,
    required this.total,
    required this.sort,
    required this.onSortChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.labelMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        Expanded(
          // Shrinks slightly on narrow screens instead of showing "prod…".
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Showing '),
              TextSpan(
                  text: '$loaded',
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              TextSpan(text: ' of $total products'),
            ]),
            style: label?.copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SortDropdown(sort: sort, onChanged: onSortChanged),
        const SizedBox(width: 8),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.discountBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune_rounded,
                size: 18, color: AppColors.discount),
          ),
        ),
      ]),
    );
  }
}
