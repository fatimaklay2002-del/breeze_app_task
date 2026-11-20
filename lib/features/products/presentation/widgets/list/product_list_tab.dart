import 'package:flutter/material.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/screen_title.dart';
import '../../../../../app/navigation/app_navigator.dart';
import '../../../data/models/product.dart';
import '../product_card/product_card.dart';

class ProductListTab extends StatelessWidget {
  final String title;
  final List<Product> products;
  final IconData emptyIcon;
  final String emptyTitle, emptySubtitle;

  const ProductListTab({
    super.key,
    required this.title,
    required this.products,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.emptySubtitle,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Column(children: [
          Align(alignment: Alignment.centerLeft, child: ScreenTitle(title)),
          Expanded(
            child: products.isEmpty
                ? EmptyView(
                    icon: emptyIcon, title: emptyTitle, subtitle: emptySubtitle)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: products.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => ProductCard(
                      product: products[i],
                      onDetails: () => openProductDetails(context, products[i]),
                    ),
                  ),
          ),
        ]),
      );
}
