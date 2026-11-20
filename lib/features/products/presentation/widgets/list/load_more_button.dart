import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import 'remaining_badge.dart';

class LoadMoreButton extends StatelessWidget {
  final bool loading;
  final int remaining;
  final VoidCallback onTap;

  const LoadMoreButton({
    super.key,
    required this.loading,
    required this.remaining,
    required this.onTap,
  });

  static const _labelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: loading ? null : onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.border, width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: loading ? _loadingRow() : _idleRow(),
      ),
    );
  }

  Widget _idleRow() => const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sync_rounded, size: 19),
          SizedBox(width: 9),
          Text('Load More Products', style: _labelStyle),
        ],
      );

  Widget _loadingRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 21,
            height: 21,
            child: CircularProgressIndicator(
              strokeWidth: 2.8,
              backgroundColor: AppColors.primaryLight,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          const Flexible(
            child: Text(
              'Loading More Products',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          RemainingBadge(remaining: remaining),
        ],
      );
}
