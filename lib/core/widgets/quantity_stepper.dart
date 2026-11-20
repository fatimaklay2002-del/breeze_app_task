import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final bool canDecrement, canIncrement;
  final VoidCallback onDecrement, onIncrement;
  final double height;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
    this.height = 52,
  });

  static const _padding = 4.0;

  @override
  Widget build(BuildContext context) {
    final button = height - _padding * 2;
    return Container(
      height: height,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _StepButton(Icons.remove_rounded, canDecrement ? onDecrement : null, button),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 36),
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        _StepButton(Icons.add_rounded, canIncrement ? onIncrement : null, button),
      ]),
    );
  }
}

/// Round button: white + dark icon when enabled, faded when disabled.
class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  const _StepButton(this.icon, this.onTap, this.size);

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: 20,
            color: enabled ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
