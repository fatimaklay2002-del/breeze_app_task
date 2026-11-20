class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = 'https://dummyjson.com';

  static const products = '/products';
  static const search = '/products/search';
  static const categories = '/products/categories';
  static String productById(int id) => '/products/$id';
  static String byCategory(String slug) => '/products/category/$slug';

  /// Public link used by the Share button.
  static String productUrl(int id) => '$baseUrl${productById(id)}';
}
