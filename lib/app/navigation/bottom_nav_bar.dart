import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../features/products/logic/products_cubit.dart';
import 'nav_cubit.dart';
import 'nav_item.dart';

/// null tab = Search (an action, not a tab).
const _items = <(IconData, String, AppTab?)>[
  (Icons.grid_view_rounded, 'Home', AppTab.home),
  (Icons.search_rounded, 'Search', null),
  (Icons.shopping_bag_outlined, 'Bag', AppTab.bag),
  (Icons.history_rounded, 'History', AppTab.history),
  (Icons.favorite_border_rounded, 'Wishlist', AppTab.wishlist),
  (Icons.settings_outlined, 'Settings', AppTab.settings),
];

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key});

  void _onTap(NavCubit nav, AppTab? tab) {
    if (tab == null) return nav.openSearch();
    FocusManager.instance.primaryFocus?.unfocus();
    nav.select(tab);
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavCubit>();
    final hasQuery =
        context.select((ProductsCubit c) => c.state.query.isNotEmpty);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(children: [
            for (final (icon, label, tab) in _items)
              Expanded(
                child: InkWell(
                  onTap: () => _onTap(nav, tab),
                  child: NavItem(
                    icon: icon,
                    label: label,
                    selected: nav.state.isSelected(tab, hasQuery: hasQuery),
                    isBag: tab == AppTab.bag,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
