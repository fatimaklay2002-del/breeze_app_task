import 'package:breeze/features/product_details/presentation/screens/product_details_screen.dart';

import '../injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/cart/logic/cart_cubit.dart';
import '../../features/history/logic/history_cubit.dart';
import 'nav_cubit.dart';
import '../../features/products/data/models/product.dart';
import '../../features/products/data/repository/product_repository.dart';
import '../../features/product_details/logic/product_details_cubit.dart';

void openProductDetails(BuildContext context, Product product) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => ProductDetailsCubit(
        sl<ProductRepository>(),
        sl<CartCubit>(),
        sl<HistoryCubit>(),
        productId: product.id,
        initial: product,
      )..load(),
      child: const ProductDetailsScreen(),
    ),
  ));
}

/// Returns to the shell and opens the Bag tab.
void goToBagTab(BuildContext context) {
  context.read<NavCubit>().select(AppTab.bag);
  Navigator.of(context).popUntil((r) => r.isFirst);
}
