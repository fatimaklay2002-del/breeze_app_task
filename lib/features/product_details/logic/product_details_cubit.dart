import 'dart:async';
import 'package:breeze/features/cart/logic/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/failures.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../history/logic/history_cubit.dart';
import '../../products/data/models/product.dart';
import '../../products/data/repository/product_repository.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repo;
  final CartCubit _cart;
  final HistoryCubit _history;
  final int productId;
  late final StreamSubscription<dynamic> _cartSub; 

  ProductDetailsCubit(
    this._repo,
    this._cart,
    this._history, {
    required this.productId,
    Product? initial,
  }) : super(ProductDetailsState.initial(initial, _cart.state.quantityOf(productId))) {
    _cartSub = _cart.stream.listen(_onCartChanged);
  }

  void _onCartChanged(CartState c) {
    final q = c.quantityOf(productId);
    if (q == state.cartQuantity) return; 
    final moq = state.product?.minimumOrderQuantity;
    emit(state.copyWith(
      cartQuantity: q,
      quantity: q > 0 ? (state.added ? q : state.quantity) : (moq ?? state.quantity),
      added: state.added && q > 0,
    ));
  }

  Future<void> load() async {
    final existing = state.product;
    if (existing != null) {
      _history.record(existing);
    } else {
      emit(state.copyWith(status: DetailsStatus.loading));
    }
    try {
      final p = await _repo.getProductById(productId);
      if (isClosed) return;
      _history.record(p);
      emit(state.copyWith(
        status: DetailsStatus.success,
        product: p,
        quantity: existing == null
            ? (state.cartQuantity > 0 ? state.cartQuantity : p.minimumOrderQuantity)
            : CartCubit.clampQuantity(p, state.quantity),
        added: existing == null ? state.cartQuantity > 0 : state.added,
      ));
    } on Failure catch (f) {
      if (isClosed || f.isCancelled) return;
      if (state.product == null) {
        emit(state.copyWith(status: DetailsStatus.failure, error: f));
      }
    }
  }

  void increment() => _setQty(state.quantity + 1);
  void decrement() => _setQty(state.quantity - 1);
  void _setQty(int q) {
    final p = state.product;
    if (p == null || !p.canBeOrdered) return;
    final clamped = CartCubit.clampQuantity(p, q);
    if (clamped == state.quantity) return;
    emit(state.copyWith(quantity: clamped, added: false));
  }

  void addToBag() {
    final p = state.product;
    if (p == null || !p.canBeOrdered || state.added) return;
    _cart.setQuantity(p, state.quantity);
    emit(state.copyWith(added: true, cartQuantity: state.quantity));
  }

  @override
  Future<void> close() {
    _cartSub.cancel();
    return super.close();
  }
}

