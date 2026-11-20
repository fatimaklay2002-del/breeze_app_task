import 'package:flutter/material.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/error_view.dart';
import '../../../logic/products_state.dart';
import 'products_loading.dart';
import 'products_pagination.dart';
import 'products_sliver_list.dart';

class ProductsBody extends StatelessWidget {
  final ProductsState state;
  final VoidCallback onRetry, onLoadMore;
  final ValueChanged<int> onPageSelected;

  const ProductsBody({
    super.key,
    required this.state,
    required this.onRetry,
    required this.onLoadMore,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final status = state.status;
    if (status == ProductsStatus.initial || status == ProductsStatus.loading) {
      return const ProductsLoading();
    }
    if (status == ProductsStatus.failure) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorView(
          message:
              state.error?.message ?? 'Something went wrong. Please try again.',
          onRetry: onRetry,
        ),
      );
    }
    if (state.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyView(
          title: 'No products found',
          subtitle: state.query.isNotEmpty
              ? 'No results for "${state.query}". Try a different keyword.'
              : 'Nothing here yet.',
        ),
      );
    }
    return SliverMainAxisGroup(slivers: [
      ProductsSliverList(products: state.products),
      if (status == ProductsStatus.loadingMore)
        const ProductsLoading(count: 2, topPadding: 12),
      ProductsPagination(
        state: state,
        onLoadMore: onLoadMore,
        onPageSelected: onPageSelected,
      ),
    ]);
  }
}
