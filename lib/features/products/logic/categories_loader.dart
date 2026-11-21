import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/failures.dart';
import '../data/repository/product_repository.dart';
import 'products_state.dart';

mixin CategoriesLoader on Cubit<ProductsState> {
  ProductRepository get repo;

  Future<void> loadCategories() async {
    try {
      final cats = await repo.getCategories();
      if (!isClosed) {
        emit(state.copyWith(categories: cats, categoriesFailed: false));
      }
    } on Failure {
      if (!isClosed) emit(state.copyWith(categoriesFailed: true));
    }
  }
}
