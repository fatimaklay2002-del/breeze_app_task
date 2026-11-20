import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../features/cart/logic/cart_cubit.dart';
import '../../features/cart/logic/cart_state.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected, isBag;
  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.isBag,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    final iconW = Icon(icon, color: color, size: 24);

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      isBag
          ? BlocSelector<CartCubit, CartState, int>(
              selector: (s) => s.totalCount,
              builder: (_, count) => Badge(
                isLabelVisible: count > 0,
                label: Text('$count'),
                backgroundColor: AppColors.primary,
                child: iconW,
              ),
            )
          : iconW,
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
    ]);
  }
}
