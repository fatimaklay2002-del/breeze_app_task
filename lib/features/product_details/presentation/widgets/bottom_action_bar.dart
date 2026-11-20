import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../logic/product_details_cubit.dart';
import '../../logic/product_details_state.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, s) {
        final p = s.product;
        if (p == null) return const SizedBox.shrink();
        final cubit = context.read<ProductDetailsCubit>();
        final reason = p.unavailableReason;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            top: false,
            child: Row(children: [
              QuantityStepper(
                quantity: s.quantity,
                canDecrement:
                    reason == null && s.quantity > p.minimumOrderQuantity,
                canIncrement: reason == null && s.quantity < p.stock,
                onDecrement: cubit.decrement,
                onIncrement: cubit.increment,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: reason != null ? null : cubit.addToBag,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          s.added ? AppColors.success : AppColors.primary,
                    ),
                    // One line only: shrinks on narrow screens instead of wrapping.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        reason ??
                            (s.added
                                ? '✓ Added to Bag (${s.cartQuantity})'
                                : 'Add to Bag • ${formatPrice(s.totalPrice)}'),
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
