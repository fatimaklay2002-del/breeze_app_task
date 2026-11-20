import 'package:equatable/equatable.dart';
import '../../../../core/utils/formatters.dart';
import 'dimensions.dart';
import 'product_json.dart';
import 'product_meta.dart';
import 'rating_summary.dart';
import 'review.dart';

class Product extends Equatable {
  final int id, stock, minimumOrderQuantity;
  final double price, discountPercentage, rating, weight;
  final String title, description, category, sku, thumbnail;
  final String warrantyInformation, shippingInformation;
  final String availabilityStatus, returnPolicy;
  final String? brand; // optional: missing for e.g. groceries
  final List<String> tags, images;
  final List<Review> reviews;
  final Dimensions dimensions;
  final ProductMeta meta;

  const Product({
    required this.id, required this.title, required this.description,
    required this.category, required this.price, required this.sku,
    required this.discountPercentage, required this.rating,
    required this.stock, required this.tags, required this.brand,
    required this.weight, required this.dimensions, required this.meta,
    required this.warrantyInformation, required this.shippingInformation,
    required this.availabilityStatus, required this.reviews,
    required this.returnPolicy, required this.minimumOrderQuantity,
    required this.images, required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      productFromJson(json);

  bool get hasBrand => brand != null && brand!.trim().isNotEmpty;
  bool get hasDiscount => discountPercentage > 0;
  int get discountRounded => discountPercentage.round();

  double get originalPrice {
    final d = discountPercentage / 100;
    return d >= 1 ? price : price / (1 - d);
  }

  double get savedAmount => originalPrice - price;

  /// Why this product can't be ordered (null = can be ordered).
  String? get unavailableReason {
    if (stock <= 0) return 'Out of stock';
    if (minimumOrderQuantity > stock) return 'Minimum order exceeds stock';
    return null;
  }

  bool get canBeOrdered => unavailableReason == null;

  // ---- display helpers (no Flutter imports, easy to unit test) ----
  String get categoryLabel => slugToTitle(category);
  String get weightLabel => '${formatNum(weight)} g';
  RatingSummary get ratingSummary => RatingSummary.fromReviews(reviews);

  @override
  List<Object?> get props => [
        id, title, description, category, price, discountPercentage, rating,
        stock, tags, brand, sku, weight, dimensions, warrantyInformation,
        shippingInformation, availabilityStatus, reviews, returnPolicy,
        minimumOrderQuantity, meta, images, thumbnail,
      ];
}
