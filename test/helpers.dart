import 'package:breeze/core/network/failures.dart';
import 'package:breeze/features/products/data/models/category.dart';
import 'package:breeze/features/products/data/models/product.dart';
import 'package:breeze/features/products/data/models/products_response.dart';
import 'package:breeze/features/products/data/models/sort_option.dart';
import 'package:breeze/features/products/data/repository/product_repository.dart';
import 'package:dio/dio.dart';

/// Builds a Product through fromJson (same path as the real API).
Product makeProduct({
  int id = 1,
  num price = 10,
  num discount = 0,
  int stock = 100,
  int moq = 1,
  String category = 'beauty',
  String? brand,
  List<Map<String, dynamic>> reviews = const [],
}) =>
    Product.fromJson({
      'id': id,
      'title': 'Product $id',
      'price': price,
      'discountPercentage': discount,
      'stock': stock,
      'minimumOrderQuantity': moq,
      'category': category,
      'brand': brand,
      'reviews': reviews,
    });

/// In-memory repository: no network, records every request.
class FakeProductRepository extends ProductRepository {
  FakeProductRepository({this.total = 12}) : super(Dio());

  final int total;
  bool fail = false;
  int calls = 0;
  String? lastQuery;
  String? lastCategory;
  final skips = <int>[];

  @override
  Future<ProductsResponse> getProducts({
    int limit = 5,
    int skip = 0,
    String? query,
    String? categorySlug,
    SortOption? sort,
    CancelToken? cancelToken,
  }) async {
    calls++;
    skips.add(skip);
    lastQuery = query;
    lastCategory = categorySlug;
    if (fail) throw const Failure(FailureType.network, 'offline');
    final count = (total - skip).clamp(0, limit);
    return ProductsResponse(
      products: [for (var i = 0; i < count; i++) makeProduct(id: skip + i + 1)],
      total: total,
      skip: skip,
      limit: limit,
    );
  }

  @override
  Future<List<Category>> getCategories() async =>
      const [Category(slug: 'beauty', name: 'Beauty')];
}
