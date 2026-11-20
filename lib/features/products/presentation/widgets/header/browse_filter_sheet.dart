import 'package:flutter/material.dart';
import '../../../data/models/category.dart';
import 'category_choice.dart';

class BrowseFilterSheet extends StatelessWidget {
  final List<Category> categories;
  final String? selectedSlug;

  const BrowseFilterSheet({
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
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) =>
            BrowseFilterSheet(categories: categories, selectedSlug: selectedSlug),
      );

  Widget _tile(BuildContext context, String title, String? slug) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        trailing: slug == selectedSlug
            ? const Icon(Icons.check_rounded, color: Colors.blue)
            : null,
        onTap: () => Navigator.of(context).pop(CategoryChoice(slug)),
      );

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.65;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter by department',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              _tile(context, 'All products', null),
              if (categories.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Departments are not available right now.'),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, i) =>
                        _tile(context, categories[i].name, categories[i].slug),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
