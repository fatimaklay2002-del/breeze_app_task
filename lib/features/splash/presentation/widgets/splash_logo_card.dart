import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
class SplashLogoCard extends StatelessWidget {
  const SplashLogoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144,
      height: 144,
      padding: const EdgeInsets.all(34),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.12),
            blurRadius: 50,
            offset: const Offset(-8, 8),
          ),
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.12),
            blurRadius: 50,
            offset: const Offset(8, 8),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/logo.png',
        errorBuilder: (_, _, _) => const Icon(
          Icons.shopping_bag_rounded,
          size: 64,
          color: AppColors.accent,
        ),
      ),
    );
  }
}
