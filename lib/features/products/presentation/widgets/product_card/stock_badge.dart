import '../../../../../core/theme/app_colors.dart';
import '../../../../cart/logic/cart_cubit.dart';
import '../../../../cart/logic/cart_state.dart';
import '../../../data/models/product.dart';
import 'product_card_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockBadge extends StatelessWidget {
  final Product product;
  const StockBadge({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (s) => s.quantityOf(product.id),
      builder: (_, qty) {
        final inBag = qty > 0;
        return ProductCardPill(
          text: inBag
              ? 'In Bag ($qty)'
              : '${product.availabilityStatus} (${product.stock})',
          bg: AppColors.successBg,
          fg: AppColors.success,
          icon: inBag ? Icons.shopping_bag_outlined : null,
        );
      },
    );
  }
}