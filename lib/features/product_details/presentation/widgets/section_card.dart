import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;
  const SectionTitle(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
        child: Row(children: [
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const Spacer(),
          if (trailing != null)
            Text(trailing!,
                style: const TextStyle(color: AppColors.textSecondary)),
        ]),
      );
}

/// White rounded card used by description, specs and reviews.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: child,
      );
}
