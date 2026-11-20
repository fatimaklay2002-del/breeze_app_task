/// Result of a category sheet. Dismissing a sheet returns null; choosing
/// "All products" returns CategoryChoice(null).
class CategoryChoice {
  final String? slug;
  const CategoryChoice(this.slug);
}
