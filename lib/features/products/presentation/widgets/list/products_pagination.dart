import 'package:flutter/material.dart';

import '../../../logic/products_state.dart';
import 'load_more_button.dart';
import 'numeric_pagination.dart';

class ProductsPagination extends StatelessWidget {
  final ProductsState state;
  final VoidCallback onLoadMore;
  final ValueChanged<int> onPageSelected;

  const ProductsPagination({
    super.key,
    required this.state,
    required this.onLoadMore,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final loadingMore = state.status == ProductsStatus.loadingMore;

    return SliverMainAxisGroup(
      slivers: [
        if (state.loadMoreFailed)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.error?.message ?? 'Failed to load more.',
                    ),
                  ),
                  TextButton(
                    onPressed: onLoadMore,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        if (state.hasMore || loadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: LoadMoreButton(
                loading: loadingMore,
                remaining: state.remaining,
                onTap: onLoadMore,
              ),
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: NumericPagination(
              currentPage: state.currentPage,
              totalPages: state.totalPages,
              onPageSelected: onPageSelected,
            ),
          ),
        ),
      ],
    );
  }
}
