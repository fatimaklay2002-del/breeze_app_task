import 'package:equatable/equatable.dart';
import '../../products/data/models/product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  double get total => product.price * quantity;
  bool get canIncrease => quantity < product.stock;
  bool get canDecrease => quantity > product.minimumOrderQuantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [product, quantity];
}
