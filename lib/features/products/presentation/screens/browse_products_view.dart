import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/products_cubit.dart';
import '../../logic/products_state.dart';
import '../widgets/header/browse_products_header.dart';
import '../widgets/list/products_body.dart';

class BrowseProductsView extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onClearSearch, onUnfocus, onScrollToTop;

  const BrowseProductsView({
    super.key,
    required this.controller,
    required this.onClearSearch,
    required this.onUnfocus,
    required this.onScrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) => CustomScrollView(
        controller: controller,
        slivers: [
          BrowseProductsHeader(
            state: state,
            onCategoryToggled: (slug) {
              onClearSearch();
              cubit.toggleCategory(slug);
            },
            onCategorySelected: (slug) {
              onClearSearch();
              cubit.selectCategory(slug);
            },
            onRetryCategories: cubit.loadCategories,
            onSortChanged: (sort) {
              onUnfocus();
              cubit.changeSort(sort);
            },
          ),
          ProductsBody(
            state: state,
            onRetry: cubit.retry,
            onLoadMore: cubit.loadMore,
            onPageSelected: (page) {
              cubit.goToPage(page);
              onScrollToTop();
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
