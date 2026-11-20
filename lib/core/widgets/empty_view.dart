import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const EmptyView({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.search_off_rounded,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
      );
}
