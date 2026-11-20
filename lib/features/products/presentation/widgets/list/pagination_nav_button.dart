import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

/// "‹ Prev" / "Next ›"
class PaginationNavButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  const PaginationNavButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24);
    return Material(
      color: Colors.white,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: const BoxConstraints(minWidth: 68),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: enabled
                  ? AppColors.border
                  : AppColors.border.withValues(alpha: 0.55),
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: enabled
                  ? AppColors.textBody
                  : AppColors.textMuted.withValues(alpha: 0.55),
            ),
          ),
        ),
      ),
    );
  }
}
