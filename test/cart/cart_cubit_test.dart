import 'package:breeze/features/cart/logic/cart_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  late CartCubit cart;
  setUp(() => cart = CartCubit());
  tearDown(() => cart.close());

  test('add uses the minimum order quantity by default', () {
    cart.add(makeProduct(moq: 20, stock: 34));
    expect(cart.state.quantityOf(1), 20);
    expect(cart.state.totalCount, 20);
  });

  test('quantity never exceeds stock', () {
    final p = makeProduct(moq: 20, stock: 34);
    cart.add(p);
    cart.add(p);
    expect(cart.state.quantityOf(1), 34);
  });

  test('product that cannot be ordered is not added', () {
    expect(cart.add(makeProduct(stock: 0)), 0);
    expect(cart.state.items, isEmpty);
  });

  test('decrease never goes below the minimum order quantity', () {
    final p = makeProduct(moq: 5, stock: 50);
    cart.add(p);
    cart.decrease(p);
    expect(cart.state.quantityOf(1), 5);
    cart.increase(p);
    expect(cart.state.quantityOf(1), 6);
  });

  test('totals are computed from price x quantity', () {
    cart.add(makeProduct(id: 1, price: 10, moq: 2));
    cart.add(makeProduct(id: 2, price: 2.5, moq: 4));
    expect(cart.state.totalCount, 6);
    expect(cart.state.totalPrice, closeTo(30, 0.0001));
  });

  test('remove and clear', () {
    cart.add(makeProduct(id: 1));
    cart.add(makeProduct(id: 2));
    cart.remove(1);
    expect(cart.state.contains(1), isFalse);
    cart.clear();
    expect(cart.state.items, isEmpty);
  });
}
