import 'package:breeze/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.splashGradientStart,
                AppColors.splashGradientMid,
                AppColors.splashGradientEnd,
              ],
              stops: [0, 0.5, 1],
            ),
          ),
        ),
        // Stands in for the Figma "Overlay + Blur" layers (makes it pale).
        ColoredBox(color: Colors.white.withValues(alpha: 0.55)),
        const Positioned(top: -120, left: -120, child: _Glow(AppColors.link, 420)),
        const Positioned(bottom: -140, left: -40, child: _Glow(AppColors.purple, 420)),
        const Positioned(top: 280, right: -180, child: _Glow(AppColors.accent, 400)),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  final double size;
  const _Glow(this.color, this.size);

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0),
            ]),
          ),
        ),
      );
}
