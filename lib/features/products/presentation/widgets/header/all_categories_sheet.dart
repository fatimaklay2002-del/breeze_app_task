import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/category.dart';
import 'category_choice.dart';
import 'category_grid_tile.dart';

class AllCategoriesSheet extends StatelessWidget {
  final List<Category> categories;
  final String? selectedSlug;

  const AllCategoriesSheet({
    super.key,
    required this.categories,
    required this.selectedSlug,
  });

  static Future<CategoryChoice?> show(
    BuildContext context, {
    required List<Category> categories,
    required String? selectedSlug,
  }) =>
      showModalBottomSheet<CategoryChoice>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        backgroundColor: Colors.white,
        builder: (_) => AllCategoriesSheet(
            categories: categories, selectedSlug: selectedSlug),
      );

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.75;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('All Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('${categories.length} departments available',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, i) => CategoryGridTile(
                    category: categories[i],
                    selected: categories[i].slug == selectedSlug,
                    onTap: () => Navigator.of(context)
                        .pop(CategoryChoice(categories[i].slug)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
