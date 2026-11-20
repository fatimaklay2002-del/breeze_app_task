import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../products/data/models/product.dart';

class InfoGrid extends StatelessWidget {
  final Product product;
  const InfoGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final items = [
      // (icon, title, value, circle tint, icon color)
      (Icons.local_shipping_outlined, 'Delivery', product.shippingInformation,
          AppColors.primary, AppColors.primary),
      (Icons.verified_user_outlined, 'Warranty', product.warrantyInformation,
          AppColors.accent, AppColors.warrantyIcon),
      (Icons.autorenew_rounded, 'Return Policy', product.returnPolicy,
          AppColors.primary, AppColors.primary),
      (Icons.check_circle_outline, 'Authenticity', '100% Genuine',
          AppColors.success, AppColors.success),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.4,
        children: [
          for (final i in items)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: i.$4.withValues(alpha: 0.12),
                  child: Icon(i.$1, size: 18, color: i.$5),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i.$2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13)),
                      Text(i.$3,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 11.5, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
