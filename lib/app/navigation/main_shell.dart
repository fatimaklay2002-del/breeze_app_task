import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/cart/presentation/screens/bag_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/products/logic/products_cubit.dart';
import '../../features/products/presentation/screens/browse_products_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/wishlist/presentation/wishlist_screen.dart';
import '../injection.dart';
import 'bottom_nav_bar.dart';
import 'nav_cubit.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsCubit>()..init(),
      child: Scaffold(
        body: BlocBuilder<NavCubit, NavState>(
          buildWhen: (a, b) => a.tab != b.tab,
          builder: (_, nav) => IndexedStack(
            index: nav.tab.index,
            children: const [
              BrowseProductsScreen(),
              BagScreen(),
              HistoryScreen(),
              WishlistScreen(),
              SettingsScreen(),
            ],
          ),
        ),
        bottomNavigationBar: const AppBottomBar(),
      ),
    );
  }
}
