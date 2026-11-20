import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/request_guard.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/products_response.dart';
import '../models/sort_option.dart';

class ProductRepository {
  final Dio _dio;
  List<Category>? _categoriesCache;
  ProductRepository(this._dio);

  
  Future<ProductsResponse> getProducts({
    int limit = 5,
    int skip = 0,
    String? query,
    String? categorySlug,
    SortOption? sort,
    CancelToken? cancelToken,
  }) {
    final q = query?.trim() ?? '';
    final params = <String, dynamic>{'limit': limit, 'skip': skip};
    if (q.isNotEmpty) params['q'] = q;
    if (sort != null) {
      params['sortBy'] = sort.field.name;
      params['order'] = sort.order.name;
    }
    final path = q.isNotEmpty
        ? ApiEndpoints.search
        : (categorySlug != null && categorySlug.isNotEmpty)
            ? ApiEndpoints.byCategory(categorySlug)
            : ApiEndpoints.products;

    return guardRequest(() async {
      final res = await _dio.get(path,
          queryParameters: params, cancelToken: cancelToken);
      return ProductsResponse.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<Product> getProductById(int id, {CancelToken? cancelToken}) =>
      guardRequest(() async {
        final res = await _dio.get(ApiEndpoints.productById(id),
            cancelToken: cancelToken);
        return Product.fromJson(res.data as Map<String, dynamic>);
      });

  Future<List<Category>?> getCategories() async {
    final cached = _categoriesCache;
    if (cached != null) return cached;
    return _categoriesCache = await guardRequest(() async {
      final res = await _dio.get(ApiEndpoints.categories);
      return (res.data as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
