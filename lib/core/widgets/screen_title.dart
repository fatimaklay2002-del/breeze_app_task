import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const ScreenTitle(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            if (subtitle != null)
              Text(subtitle!,
                  style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );
}
