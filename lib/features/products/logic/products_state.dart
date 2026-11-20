import 'package:equatable/equatable.dart';
import '../../../core/network/failures.dart';
import '../data/models/category.dart';
import '../data/models/product.dart';
import '../data/models/sort_option.dart';

enum ProductsStatus { initial, loading, success, loadingMore, failure }

class ProductsState extends Equatable {
  static const pageSize = 5;
  static const Object _unset = Object();

  final ProductsStatus status;
  final List<Product> products;
  final List<Category> categories;
  final bool categoriesFailed, loadMoreFailed;
  final int total, currentPage, offset;
  final String query;
  final String? categorySlug;
  final SortOption? sort;
  final Failure? error;

  const ProductsState({
    this.status = ProductsStatus.initial, this.products = const [],
    this.categories = const [], this.categoriesFailed = false,
    this.total = 0, this.currentPage = 1, this.offset = 0, this.query = '',
    this.categorySlug, this.sort, this.error, this.loadMoreFailed = false,
  });

  int get loaded => products.length;
  int get nextSkip => offset + loaded;
  int get remaining => (total - nextSkip).clamp(0, total);
  int get totalPages => total == 0 ? 0 : (total / pageSize).ceil();
  bool get hasMore => nextSkip < total;
  bool get isEmpty => status == ProductsStatus.success && products.isEmpty;

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    List<Category>? categories,
    bool? categoriesFailed,
    int? total,
    int? currentPage,
    int? offset,
    String? query,
    String? Function()? categorySlug,
    SortOption? Function()? sort,
    Object? error = _unset,
    bool? loadMoreFailed,
  }) =>
      ProductsState(
        status: status ?? this.status,
        products: products ?? this.products,
        categories: categories ?? this.categories,
        categoriesFailed: categoriesFailed ?? this.categoriesFailed,
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        offset: offset ?? this.offset,
        query: query ?? this.query,
        categorySlug: categorySlug != null ? categorySlug() : this.categorySlug,
        sort: sort != null ? sort() : this.sort,
        error: identical(error, _unset) ? this.error : error as Failure?,
        loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
      );

  @override
  List<Object?> get props => [
        status, products, categories, categoriesFailed, total, currentPage,
        offset, query, categorySlug, sort, error, loadMoreFailed,
      ];
}
