import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/sort_option.dart';

class SortDropdown extends StatelessWidget {
  final SortOption? sort;
  final ValueChanged<SortOption?> onChanged;
  const SortDropdown({super.key, required this.sort, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.labelMedium;
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SortOption?>(
          value: sort,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          style: label?.copyWith(color: AppColors.textPrimary),
          items: <DropdownMenuItem<SortOption?>>[
            const DropdownMenuItem<SortOption?>(
              value: null,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.schedule_rounded,
                    size: 16, color: AppColors.textSecondary),
                SizedBox(width: 6),
                Text('Recently added'),
              ]),
            ),
            for (final o in SortOption.all)
              DropdownMenuItem<SortOption?>(value: o, child: Text(o.label)),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
