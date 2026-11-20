import '../../../../../core/theme/app_colors.dart';
import '../../../../cart/logic/cart_cubit.dart';
import '../../../../cart/logic/cart_state.dart';
import '../../../data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddButton extends StatelessWidget {
  final Product product;
  const AddButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (s) => s.quantityOf(product.id),
      builder: (context, qty) {
        final added = qty > 0;
        return SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: product.canBeOrdered
                ? () {
                    if (!added) context.read<CartCubit>().add(product);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: added ? AppColors.success : AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            icon: Icon(
                added
                    ? Icons.check_circle_outline
                    : Icons.add_shopping_cart_rounded,
                size: 18),
            label: Text(added ? 'Added ($qty)' : 'Add'),
          ),
        );
      },
    );
  }
}