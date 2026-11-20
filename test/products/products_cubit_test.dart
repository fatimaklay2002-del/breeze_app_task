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

  test('init loads the first page and the categories', () {
    expect(cubit.state.status, ProductsStatus.success);
    expect(cubit.state.loaded, 5);
    expect(cubit.state.total, 12);
    expect(cubit.state.totalPages, 3);
    expect(cubit.state.remaining, 7);
    expect(cubit.state.categories, isNotEmpty);
  });

  test('loadMore appends without removing previous products', () async {
    await cubit.loadMore();
    expect(cubit.state.products.map((p) => p.id), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    expect(cubit.state.remaining, 2);
    expect(cubit.state.currentPage, 2);
    expect(repo.skips, [0, 5]);
  });

  test('numeric pagination replaces the list', () async {
    await cubit.goToPage(2);
    expect(cubit.state.products.map((p) => p.id), [6, 7, 8, 9, 10]);
    expect(cubit.state.currentPage, 2);
  });

  test('re-tapping the current page does not hit the API', () async {
    await cubit.goToPage(1);
    expect(repo.calls, 1);
  });

  test('current page is reloaded after Load More merged pages', () async {
    await cubit.loadMore();
    await cubit.goToPage(2);
    expect(cubit.state.loaded, 5);
    expect(repo.calls, 3);
  });
}
