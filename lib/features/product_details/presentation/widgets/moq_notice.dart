import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';

class MoqNotice extends StatelessWidget {
  final Product product;
  const MoqNotice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const bold = TextStyle(fontWeight: FontWeight.w700);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: [
        const Icon(Icons.inventory_2_outlined,
            size: 20, color: AppColors.moqText),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'MOQ Notice: ', style: bold),
              const TextSpan(text: 'Minimum order quantity is '),
              TextSpan(
                  text: '${product.minimumOrderQuantity} units', style: bold),
              TextSpan(
                  text: ' for this wholesale '
                      '${product.categoryLabel.toLowerCase()} line.'),
            ]),
            style: const TextStyle(
                fontSize: 12, height: 15 / 12, color: AppColors.moqText),
          ),
        ),
      ]),
    );
  }
}
