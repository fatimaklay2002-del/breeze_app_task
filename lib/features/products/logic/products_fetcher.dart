import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/failures.dart';
import '../data/models/products_response.dart';
import '../data/repository/product_repository.dart';
import 'products_state.dart';

/// Page loading (replace / append) with cancellation of stale requests.
mixin ProductsFetcher on Cubit<ProductsState> {
  ProductRepository get repo;
  CancelToken? _token;

  /// One request for the current query / category / sort.
  Future<ProductsResponse> _request(int skip) {
    _token?.cancel(); // a newer request makes the old one obsolete
    return repo.getProducts(
      limit: ProductsState.pageSize,
      skip: skip,
      query: state.query,
      categorySlug: state.categorySlug,
      sort: state.sort,
      cancelToken: _token = CancelToken(),
    );
  }

  /// Numeric pagination / first load: replaces the list.
  Future<void> fetchPage({required int page}) async {
    final skip = (page - 1) * ProductsState.pageSize;
    emit(state.copyWith(
      status: ProductsStatus.loading,
      currentPage: page, // so Retry re-requests the same page
      offset: skip,
      loadMoreFailed: false,
    ));
    try {
      final res = await _request(skip);
      if (isClosed) return;
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: res.products,
        total: res.total,
        currentPage: page,
        error: null,
      ));
    } on Failure catch (f) {
      if (f.isCancelled || isClosed) return;
      emit(state.copyWith(status: ProductsStatus.failure, error: f));
    }
  }

  /// Load More: appends to the current list.
  Future<void> loadMore() async {
    final busy = state.status == ProductsStatus.loadingMore ||
        state.status == ProductsStatus.loading;
    if (busy || !state.hasMore) return;
    emit(state.copyWith(
        status: ProductsStatus.loadingMore, loadMoreFailed: false));
    try {
      final res = await _request(state.nextSkip);
      if (isClosed) return;
      final all = [...state.products, ...res.products];
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: all,
        total: res.total,
        currentPage: ((state.offset + all.length) / ProductsState.pageSize).ceil(),
        error: null,
      ));
    } on Failure catch (f) {
      if (f.isCancelled || isClosed) return;
      emit(state.copyWith(
          status: ProductsStatus.success, loadMoreFailed: true, error: f));
    }
  }

  void cancelRequests() => _token?.cancel();
}
