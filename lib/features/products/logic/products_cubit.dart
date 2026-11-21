import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/sort_option.dart';
import '../data/repository/product_repository.dart';
import 'categories_loader.dart';
import 'products_fetcher.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState>
    with ProductsFetcher, CategoriesLoader {
  @override
  final ProductRepository repo;
  Timer? _debounce;

  static const _debounceDuration = Duration(milliseconds: 500);

  ProductsCubit(this.repo) : super(const ProductsState());

  Future<void> init() {
    unawaited(loadCategories());
    return fetchPage(page: 1);
  }

  /// Debounced while typing; [search] runs immediately on submit.
  void onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () => search(value));
  }

  Future<void> search(String value) {
    _debounce?.cancel();
    final q = value.trim();
    if (q == state.query) return Future.value();
    // The API can't combine search and category: search clears the category.
    emit(state.copyWith(query: q, categorySlug: () => null));
    return fetchPage(page: 1);
  }

  /// Tapping the selected chip again clears the filter.
  Future<void> toggleCategory(String slug) =>
      selectCategory(slug == state.categorySlug ? null : slug);

  Future<void> selectCategory(String? slug) {
    _debounce?.cancel();
    if (slug == state.categorySlug && state.query.isEmpty) {
      return Future.value();
    }
    emit(state.copyWith(categorySlug: () => slug, query: ''));
    return fetchPage(page: 1);
  }

  Future<void> changeSort(SortOption? sort) {
    if (sort == state.sort) return Future.value();
    emit(state.copyWith(sort: () => sort));
    return fetchPage(page: 1);
  }

  Future<void> goToPage(int page) {
    final same =
        page == state.currentPage && state.loaded <= ProductsState.pageSize;
    if (page < 1 || page > state.totalPages || same) return Future.value();
    return fetchPage(page: page);
  }

  Future<void> retry() {
    if (state.categories.isEmpty) unawaited(loadCategories());
    return fetchPage(page: state.currentPage);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    cancelRequests();
    return super.close();
  }
}
