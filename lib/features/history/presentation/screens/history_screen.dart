import 'package:breeze/features/products/presentation/widgets/list/product_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/data/models/product.dart';
import '../../logic/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HistoryCubit, List<Product>>(
        builder: (_, products) => ProductListTab(
          title: 'History',
          products: products,
          emptyIcon: Icons.history_rounded,
          emptyTitle: 'No viewed products yet',
          emptySubtitle: 'Products you open will appear here.',
        ),
      );
}
