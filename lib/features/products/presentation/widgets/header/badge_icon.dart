import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  final IconData icon;
  final int? count;
  final bool dot;
  const BadgeIcon({super.key, required this.icon, this.count, this.dot = false});

  @override
  Widget build(BuildContext context) {
    final iconW = Icon(icon, size: 24, color: AppColors.primary);
    if (count != null) {
      return Badge(
          label: Text('$count'),
          backgroundColor: AppColors.discount,
          child: iconW);
    }
    if (dot) {
      return Badge(
          smallSize: 8, backgroundColor: AppColors.primary, child: iconW);
    }
    return iconW;
  }
}
