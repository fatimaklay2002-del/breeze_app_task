import 'package:breeze/features/products/data/models/sort_option.dart';
import 'package:breeze/features/products/logic/products_cubit.dart';
import 'package:breeze/features/products/logic/products_state.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  late FakeProductRepository repo;
  late ProductsCubit cubit;

  setUp(() async {
    repo = FakeProductRepository(total: 12);
    cubit = ProductsCubit(repo);
    await cubit.init();
  });
  tearDown(() => cubit.close());

  test('search clears the category and sends the query', () async {
    await cubit.selectCategory('beauty');
    expect(repo.lastCategory, 'beauty');
    await cubit.search('  mascara ');
    expect(cubit.state.categorySlug, isNull);
    expect(cubit.state.query, 'mascara');
    expect(repo.lastQuery, 'mascara');
  });

  test('choosing a category clears the search', () async {
    await cubit.search('mascara');
    await cubit.selectCategory('beauty');
    expect(cubit.state.query, isEmpty);
    expect(cubit.state.categorySlug, 'beauty');
  });

  test('toggleCategory twice clears the filter', () async {
    await cubit.toggleCategory('beauty');
    expect(cubit.state.categorySlug, 'beauty');
    await cubit.toggleCategory('beauty');
    expect(cubit.state.categorySlug, isNull);
  });

  test('selecting the same category again is a no-op', () async {
    await cubit.selectCategory('beauty');
    final calls = repo.calls;
    await cubit.selectCategory('beauty');
    expect(repo.calls, calls);
  });

  test('changing sort reloads from page 1', () async {
    await cubit.goToPage(2);
    await cubit.changeSort(SortOption.all.first);
    expect(cubit.state.currentPage, 1);
    expect(cubit.state.sort, SortOption.all.first);
  });

  test('failure shows an error state and Retry recovers', () async {
    repo.fail = true;
    await cubit.goToPage(2);
    expect(cubit.state.status, ProductsStatus.failure);
    expect(cubit.state.error?.message, 'offline');
    repo.fail = false;
    await cubit.retry();
    expect(cubit.state.status, ProductsStatus.success);
    expect(cubit.state.currentPage, 2);
  });

  test('empty result is detected', () async {
    final empty = ProductsCubit(FakeProductRepository(total: 0));
    await empty.init();
    expect(empty.state.isEmpty, isTrue);
    await empty.close();
  });
}
