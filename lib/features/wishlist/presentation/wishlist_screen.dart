import 'package:breeze/features/products/presentation/widgets/list/product_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/wishlist_cubit.dart';
import '../logic/wishlist_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WishlistCubit, WishlistState>(
        builder: (_, s) => ProductListTab(
          title: 'Wishlist',
          products: s.products,
          emptyIcon: Icons.bookmark_border_rounded,
          emptyTitle: 'Your wishlist is empty',
          emptySubtitle: 'Tap the bookmark icon on any product to save it here.',
        ),
      );
}
