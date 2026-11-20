import 'package:flutter/material.dart';
import '../../../data/models/sort_option.dart';
import '../../../logic/products_state.dart';
import 'all_categories_sheet.dart';
import 'browse_filter_sheet.dart';
import 'categories_row.dart';
import 'category_choice.dart';
import 'status_row.dart';

class BrowseProductsHeader extends StatelessWidget {
  final ProductsState state;
  final ValueChanged<String> onCategoryToggled; // chip tap (toggles)
  final ValueChanged<String?> onCategorySelected; // sheets (null = all)
  final VoidCallback onRetryCategories;
  final ValueChanged<SortOption?> onSortChanged;

  const BrowseProductsHeader({
    super.key,
    required this.state,
    required this.onCategoryToggled,
    required this.onCategorySelected,
    required this.onRetryCategories,
    required this.onSortChanged,
  });

  Future<void> _pick(
    BuildContext context,
    Future<CategoryChoice?> Function(BuildContext) open,
  ) async {
    final choice = await open(context);
    if (!context.mounted || choice == null) return;
    onCategorySelected(choice.slug);
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Text('Browse Products',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        ),
      ),
      SliverToBoxAdapter(
        child: CategoriesRow(
          categories: state.categories,
          failed: state.categoriesFailed,
          selectedSlug: state.categorySlug,
          onSelect: onCategoryToggled,
          onRetry: onRetryCategories,
          onViewAll: () => _pick(
            context,
            (c) => AllCategoriesSheet.show(c,
                categories: state.categories, selectedSlug: state.categorySlug),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: StatusRow(
          loaded: state.loaded,
          total: state.total,
          sort: state.sort,
          onSortChanged: onSortChanged,
          onFilterTap: () => _pick(
            context,
            (c) => BrowseFilterSheet.show(c,
                categories: state.categories, selectedSlug: state.categorySlug),
          ),
        ),
      ),
    ]);
  }
}
