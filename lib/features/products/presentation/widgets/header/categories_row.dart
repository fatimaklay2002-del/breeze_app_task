import 'package:flutter/material.dart';
import '../../../data/models/category.dart';
import 'categories_header.dart';
import 'categories_skeleton.dart';
import 'category_item.dart';

class CategoriesRow extends StatelessWidget {
  final List<Category> categories;
  final bool failed;
  final String? selectedSlug;
  final ValueChanged<String> onSelect;
  final VoidCallback onViewAll;
  final VoidCallback onRetry;

  const CategoriesRow({
    super.key,
    required this.categories,
    required this.failed,
    required this.selectedSlug,
    required this.onSelect,
    required this.onViewAll,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CategoriesHeader(onViewAll: onViewAll),
      const SizedBox(height: 10),
      SizedBox(height: 84, child: _content()),
    ]);
  }

  Widget _content() {
    if (categories.isNotEmpty) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (_, i) => CategoryItem(
          category: categories[i],
          selected: categories[i].slug == selectedSlug,
          onTap: () => onSelect(categories[i].slug),
        ),
      );
    }
    if (!failed) return const CategoriesSkeleton();
    return Center(
      child: TextButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: const Text("Couldn't load departments. Tap to retry"),
      ),
    );
  }
}
