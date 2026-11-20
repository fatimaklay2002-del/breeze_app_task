import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products/data/models/product.dart';

/// Recently opened products (newest first, no duplicates).
class HistoryCubit extends Cubit<List<Product>> {
  static const maxItems = 20;

  HistoryCubit() : super(const []);

  void record(Product product) {
    emit([product, ...state.where((p) => p.id != product.id)]
        .take(maxItems)
        .toList());
  }

  void clear() => emit(const []);
}
