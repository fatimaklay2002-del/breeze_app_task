import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products/data/models/product.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState());

  void toggle(Product product) {
    final updated = Map<int, Product>.from(state.items);
    if (updated.remove(product.id) == null) updated[product.id] = product;
    emit(WishlistState(items: updated));
  }

  void clear() => emit(const WishlistState());
}
