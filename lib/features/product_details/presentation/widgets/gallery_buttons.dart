import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';
import '../../../wishlist/logic/wishlist_cubit.dart';
import '../../../wishlist/logic/wishlist_state.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withValues(alpha: 0.92),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
              width: 40, height: 40, child: Icon(icon, size: 20, color: color)),
        ),
      );
}

/// Floating heart + zoom buttons over the image.
class GalleryActions extends StatelessWidget {
  final Product product;
  final VoidCallback onZoom;
  const GalleryActions({super.key, required this.product, required this.onZoom});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocSelector<WishlistCubit, WishlistState, bool>(
        selector: (s) => s.contains(product.id),
        builder: (context, fav) => RoundIconButton(
          icon: fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: fav ? Colors.red : AppColors.textPrimary,
          onTap: () => context.read<WishlistCubit>().toggle(product),
        ),
      ),
      const SizedBox(height: 8),
      RoundIconButton(icon: Icons.zoom_out_map_rounded, onTap: onZoom),
    ]);
  }
}
