import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/navigation/app_navigator.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../cart/logic/cart_state.dart';
import '../../../products/data/models/product.dart';
import '../../../wishlist/logic/wishlist_cubit.dart';
import '../../../wishlist/logic/wishlist_state.dart';

class DetailsTopBar extends StatelessWidget {
  final int productId;
  final Product? product;

  const DetailsTopBar({super.key, required this.productId, this.product});

  @override
  Widget build(BuildContext context) {
    final p = product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        const Expanded(
          child: Text('Product Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        if (p != null) ...[
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: ApiEndpoints.productUrl(productId)));
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Link copied')));
            },
          ),
          BlocSelector<WishlistCubit, WishlistState, bool>(
            selector: (s) => s.contains(p.id),
            builder: (context, fav) => IconButton(
              icon: Icon(
                  fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: fav ? Colors.red : null),
              onPressed: () => context.read<WishlistCubit>().toggle(p),
            ),
          ),
        ],
        BlocSelector<CartCubit, CartState, int>(
          selector: (s) => s.totalCount,
          builder: (context, count) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => goToBagTab(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  backgroundColor: AppColors.success,
                  child: const Icon(Icons.shopping_bag_outlined, size: 26),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
