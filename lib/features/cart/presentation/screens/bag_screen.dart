import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/screen_title.dart';
import '../widgets/bag_item_tile.dart';
import '../../logic/cart_cubit.dart';
import '../../logic/cart_state.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items.values.toList();
          return Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ScreenTitle(
                'My Bag',
                subtitle: items.isEmpty
                    ? null
                    : '${items.length} products · ${state.totalCount} units',
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyView(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Your bag is empty',
                      subtitle:
                          'Add products from Home and they will appear here.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => BagItemTile(item: items[i]),
                    ),
            ),
            if (items.isNotEmpty)
              _Summary(count: state.totalCount, total: state.totalPrice),
          ]);
        },
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  final int count;
  final double total;
  const _Summary({required this.count, required this.total});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(children: [
          Text('Total ($count units)',
              style: const TextStyle(color: AppColors.textSecondary)),
          const Spacer(),
          Text(formatPrice(total),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary)),
        ]),
      );
}
