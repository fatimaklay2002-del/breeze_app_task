import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import 'badge_icon.dart';
import 'search_field.dart';

class BrowseTopBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged, onSubmitted;
  const BrowseTopBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(bottom: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Image.asset('assets/images/logo.png'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SearchField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        const SizedBox(width: 8),
        const BadgeIcon(icon: Icons.chat_bubble_outline_rounded, count: 2),
        const SizedBox(width: 4),
        const BadgeIcon(icon: Icons.notifications_none_rounded, dot: true),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, size: 18, color: Colors.white),
        ),
      ]),
    );
  }
}
