import '../features/splash/logic/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../features/cart/logic/cart_cubit.dart';
import '../features/history/logic/history_cubit.dart';
import 'navigation/nav_cubit.dart';
import '../features/products/data/repository/product_repository.dart';
import '../features/products/logic/products_cubit.dart';
import '../features/wishlist/logic/wishlist_cubit.dart';
import '../core/network/dio_client.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<Dio>(createDio);
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository(sl()));

  sl.registerLazySingleton<CartCubit>(CartCubit.new);
  sl.registerLazySingleton<WishlistCubit>(WishlistCubit.new);
  sl.registerLazySingleton<HistoryCubit>(HistoryCubit.new);
  sl.registerLazySingleton<NavCubit>(NavCubit.new);

  sl.registerFactory<ProductsCubit>(() => ProductsCubit(sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));
}
