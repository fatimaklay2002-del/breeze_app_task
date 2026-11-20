import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products/data/models/product.dart';
import '../data/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());
  int add(Product product, {int? quantity}) {
    if (!product.canBeOrdered) return 0;

    final current = state.quantityOf(product.id);
    final requested = quantity ?? product.minimumOrderQuantity;
    final next = clampQuantity(product, current + requested);

    _emitWith(product, next);
    return next;
  }


  void setQuantity(Product product, int quantity) {
    if (quantity <= 0 || !product.canBeOrdered) {
      remove(product.id);
      return;
    }
    _emitWith(product, clampQuantity(product, quantity));
  }

  void increase(Product product) =>
      setQuantity(product, state.quantityOf(product.id) + 1);

  void decrease(Product product) {
    if (state.quantityOf(product.id) <= product.minimumOrderQuantity) return;
    setQuantity(product, state.quantityOf(product.id) - 1);
  }

  void remove(int productId) {
    final updated = Map<int, CartItem>.from(state.items)..remove(productId);
    emit(CartState(items: updated));
  }

  void clear() => emit(const CartState());

  void _emitWith(Product product, int quantity) {
    final updated = Map<int, CartItem>.from(state.items)
      ..[product.id] = CartItem(product: product, quantity: quantity);
    emit(CartState(items: updated));
  }


  static int clampQuantity(Product product, int quantity) {
    if (!product.canBeOrdered) return 0;
    return quantity.clamp(product.minimumOrderQuantity, product.stock);
  }
}
