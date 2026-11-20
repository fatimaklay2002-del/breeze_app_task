import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/navigation/nav_cubit.dart';
import '../../logic/products_cubit.dart';
import 'browse_products_view.dart';
import '../widgets/header/top_bar.dart';

class BrowseProductsScreen extends StatefulWidget {
  const BrowseProductsScreen({super.key});

  @override
  State<BrowseProductsScreen> createState() => _BrowseProductsScreenState();
}

class _BrowseProductsScreenState extends State<BrowseProductsScreen> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() =>
      context.read<NavCubit>().setSearchFocused(_searchFocus.hasFocus);
  @override
  void dispose() {
    _searchFocus.removeListener(_onFocusChanged);
    _searchController.dispose();
    _searchFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _clearSearch() => _searchController.clear();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return BlocListener<NavCubit, NavState>(
      listenWhen: (a, b) => a.searchRequests != b.searchRequests,
      listener: (_, _) {
        _scrollToTop();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _searchFocus.requestFocus();
        });
      },
      child: SafeArea(
        bottom: false,
        child: Column(children: [
          BrowseTopBar(
            controller: _searchController,
            focusNode: _searchFocus,
            onChanged: cubit.onSearchChanged,
            onSubmitted: cubit.search,
          ),
          Expanded(
            child: BrowseProductsView(
              controller: _scrollController,
              onClearSearch: () {
                _clearSearch();
                _searchFocus.unfocus();
              },
              onUnfocus: _searchFocus.unfocus,
              onScrollToTop: _scrollToTop,
            ),
          ),
        ]),
      ),
    );
  }
}
