import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/pagination.dart';
import 'page_button.dart';
import 'pagination_nav_button.dart';

/// < Prev, 1, 2, 3, ..., N, Next >
class NumericPagination extends StatelessWidget {
  final int currentPage, totalPages;
  final ValueChanged<int> onPageSelected;

  const NumericPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  static const _gap = SizedBox(width: 8);

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    // Scales down to always fit the screen width (no horizontal scrolling).
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          PaginationNavButton(
            label: '‹ Prev',
            enabled: currentPage > 1,
            onTap: () => onPageSelected(currentPage - 1),
          ),
          _gap,
          for (final page in buildPageWindow(currentPage, totalPages)) ...[
            if (page == null)
              const SizedBox(
                width: 24,
                child: Text('…',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    )),
              )
            else
              PageButton(
                page: page,
                selected: page == currentPage,
                onTap: () => onPageSelected(page),
              ),
            _gap,
          ],
          PaginationNavButton(
            label: 'Next ›',
            enabled: currentPage < totalPages,
            onTap: () => onPageSelected(currentPage + 1),
          ),
        ]),
      ),
    );
  }
}
