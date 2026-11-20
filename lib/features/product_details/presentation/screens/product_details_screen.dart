import 'package:breeze/core/widgets/error_view.dart';
import 'package:breeze/features/product_details/logic/product_details_cubit.dart';
import 'package:breeze/features/product_details/logic/product_details_state.dart';
import 'package:breeze/features/product_details/presentation/widgets/added_snack_bar.dart';
import 'package:breeze/features/product_details/presentation/widgets/bottom_action_bar.dart';
import 'package:breeze/features/product_details/presentation/widgets/details_skeleton.dart';
import 'package:breeze/features/product_details/presentation/widgets/details_top_bar.dart';
import 'package:breeze/features/product_details/presentation/widgets/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _reviewsKey = GlobalKey();

  void _scrollToReviews() {
    final ctx = _reviewsKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();

    return BlocListener<ProductDetailsCubit, ProductDetailsState>(
      listenWhen: (a, b) => !a.added && b.added,
      listener: (context, s) => showAddedSnackBar(context, s.quantity),
      child: Scaffold(
        bottomNavigationBar: const BottomActionBar(),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, s) {
              final p = s.product;
              return Column(children: [
                DetailsTopBar(productId: cubit.productId, product: p),
                Expanded(
                  child: p != null
                      ? ProductDetailsBody(
                          product: p,
                          reviewsKey: _reviewsKey,
                          onReviewsTap: _scrollToReviews,
                        )
                      : s.status == DetailsStatus.failure
                          ? ErrorView(
                              message: s.error?.message ??
                                  'Something went wrong. Please try again.',
                              onRetry: cubit.load,
                            )
                          : const DetailsSkeleton(),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
