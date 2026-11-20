import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SplashBrandText extends StatelessWidget {
  const SplashBrandText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Breeze',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            color: AppColors.splashTitle,
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            'Effortless wholesale & retail shopping,\ndelivered at your fingertips.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.splashSubtitle,
            ),
          ),
        ),
      ],
    );
  }
}
