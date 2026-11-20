import 'dimensions.dart';
import 'product.dart';
import 'product_meta.dart';
import 'review.dart';

/// Tolerant parsing: missing / null fields never throw (brand stays null).
Product productFromJson(Map<String, dynamic> j) {
  final thumb = j['thumbnail'] as String? ?? '';
  final imgs = List<String>.from(j['images'] ?? const []);
  String str(String k, [String d = '-']) => j[k] as String? ?? d;
  double dbl(String k) => (j[k] as num?)?.toDouble() ?? 0; // num -> double
  return Product(
    id: j['id'] as int,
    title: str('title', ''),
    description: str('description', ''),
    category: str('category', ''),
    price: dbl('price'),
    discountPercentage: dbl('discountPercentage'),
    rating: dbl('rating'),
    stock: (j['stock'] as num?)?.toInt() ?? 0,
    tags: List<String>.from(j['tags'] ?? const []),
    brand: j['brand'] as String?,
    sku: str('sku'),
    weight: dbl('weight'),
    dimensions: Dimensions.fromJson(j['dimensions'] as Map<String, dynamic>?),
    warrantyInformation: str('warrantyInformation'),
    shippingInformation: str('shippingInformation'),
    availabilityStatus: str('availabilityStatus'),
    reviews: (j['reviews'] as List? ?? const [])
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList(),
    returnPolicy: str('returnPolicy'),
    minimumOrderQuantity: (j['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
    meta: ProductMeta.fromJson(j['meta'] as Map<String, dynamic>?),
    images: imgs.isNotEmpty ? imgs : [if (thumb.isNotEmpty) thumb],
    thumbnail: thumb,
  );
}
