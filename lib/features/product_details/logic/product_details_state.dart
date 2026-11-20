import 'package:equatable/equatable.dart';
import '../../../core/network/failures.dart';
import '../../products/data/models/product.dart';

enum DetailsStatus { loading, success, failure }

class ProductDetailsState extends Equatable {
  final DetailsStatus status;
  final Product? product;
  final int quantity; 
  final int cartQuantity; 
  final bool added;
  final Failure? error;

  const ProductDetailsState({
    this.status = DetailsStatus.loading,
    this.product,
    this.quantity = 1,
    this.cartQuantity = 0,
    this.added = false,
    this.error,
  });

  factory ProductDetailsState.initial(Product? p, int inBag) =>
      ProductDetailsState(
        status: p == null ? DetailsStatus.loading : DetailsStatus.success,
        product: p,
        quantity: inBag > 0 ? inBag : (p?.minimumOrderQuantity ?? 1),
        cartQuantity: inBag,
        added: p != null && inBag > 0,
      );

  double get totalPrice => (product?.price ?? 0) * quantity;

  ProductDetailsState copyWith({
    DetailsStatus? status,
    Product? product,
    int? quantity,
    int? cartQuantity,
    bool? added,
    Failure? error,
  }) =>
      ProductDetailsState(
        status: status ?? this.status,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        cartQuantity: cartQuantity ?? this.cartQuantity,
        added: added ?? this.added,
        error: error,
      );

  @override
  List<Object?> get props =>
      [status, product, quantity, cartQuantity, added, error];
}
