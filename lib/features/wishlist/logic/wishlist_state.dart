import 'package:equatable/equatable.dart';
import '../../products/data/models/product.dart';

class WishlistState extends Equatable {
  final Map<int, Product> items;

  const WishlistState({this.items = const {}});

  bool contains(int productId) => items.containsKey(productId);

  /// Newest first
  List<Product> get products => items.values.toList().reversed.toList();

  @override
  List<Object?> get props => [items];
}
