import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/product.dart';
import '../../../../wishlist/logic/wishlist_cubit.dart';
import '../../../../wishlist/logic/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistButton extends StatelessWidget {
  final Product product;
  const WishlistButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WishlistCubit, WishlistState, bool>(
      selector: (s) => s.contains(product.id),
      builder: (context, fav) => InkWell(
        onTap: () => context.read<WishlistCubit>().toggle(product),
        child: Icon(
          fav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: 22,
          color: fav ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}