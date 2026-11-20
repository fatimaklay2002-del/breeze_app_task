import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class PageButton extends StatelessWidget {
  final int page;
  final bool selected;
  final VoidCallback onTap;
  const PageButton({
    super.key,
    required this.page,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Page $page',
      child: Material(
        color: selected ? AppColors.primary : Colors.white,
        shape: CircleBorder(
          side: BorderSide(
              color: selected ? AppColors.primary : AppColors.border),
        ),
        elevation: selected ? 2 : 0,
        shadowColor: AppColors.primary.withValues(alpha: 0.22),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap, // the cubit ignores a re-tap of the current page
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Text(
                '$page',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
