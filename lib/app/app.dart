import '../features/history/logic/history_cubit.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../features/cart/logic/cart_cubit.dart';

import '../features/wishlist/logic/wishlist_cubit.dart';
import 'injection.dart';
import 'navigation/nav_cubit.dart';

class BreezeApp extends StatelessWidget {
  const BreezeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<CartCubit>()),
        BlocProvider.value(value: sl<WishlistCubit>()),
        BlocProvider.value(value: sl<HistoryCubit>()),
        BlocProvider.value(value: sl<NavCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Breeze',
        theme: AppTheme.light,
        home: const SplashScreen(),
      ),
    );
  }
}
