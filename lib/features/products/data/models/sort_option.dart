import 'package:equatable/equatable.dart';

enum SortField { price, rating, title }

enum SortOrder { asc, desc }

class SortOption extends Equatable {
  final SortField field;
  final SortOrder order;

  const SortOption(this.field, this.order);

  static const all = [
    SortOption(SortField.price, SortOrder.asc),
    SortOption(SortField.price, SortOrder.desc),
    SortOption(SortField.rating, SortOrder.desc),
    SortOption(SortField.title, SortOrder.asc),
  ];

  String get label => switch ((field, order)) {
        (SortField.price, SortOrder.asc) => 'Price: Low to High',
        (SortField.price, SortOrder.desc) => 'Price: High to Low',
        (SortField.rating, _) => 'Top Rated',
        (SortField.title, _) => 'Name: A to Z',
      };

  @override
  List<Object?> get props => [field, order];
}
