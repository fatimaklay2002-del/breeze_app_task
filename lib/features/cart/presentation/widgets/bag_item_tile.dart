import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../data/cart_item.dart';
import '../../logic/cart_cubit.dart';
import 'bag_item_info.dart';

class BagItemTile extends StatelessWidget {
  final CartItem item;
  const BagItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    final cart = context.read<CartCubit>();

    return InkWell(
      onTap: () => openProductDetails(context, p),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: AppNetworkImage(url: p.thumbnail, cacheWidth: 240),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: BagItemInfo(item: item)),
          const SizedBox(width: 8),
          Column(children: [
            InkWell(
              onTap: () => cart.remove(p.id),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.delete_outline_rounded,
                    size: 22, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 8),
            QuantityStepper(
              height: 36,
              quantity: item.quantity,
              canDecrement: item.canDecrease,
              canIncrement: item.canIncrease,
              onDecrement: () => cart.decrease(p),
              onIncrement: () => cart.increase(p),
            ),
          ]),
        ]),
      ),
    );
  }
}
