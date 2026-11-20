import 'package:equatable/equatable.dart';
import '../data/cart_item.dart';

class CartState extends Equatable {
  final Map<int, CartItem> items;

  const CartState({this.items = const {}});

  /// Sum of quantities (bag badge)
  int get totalCount => items.values.fold(0, (sum, i) => sum + i.quantity);

  double get totalPrice => items.values.fold(0.0, (sum, i) => sum + i.total);

  int quantityOf(int productId) => items[productId]?.quantity ?? 0;

  bool contains(int productId) => items.containsKey(productId);

  @override
  List<Object?> get props => [items];
}
