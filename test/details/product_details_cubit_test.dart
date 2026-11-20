import 'package:breeze/features/cart/logic/cart_cubit.dart';
import 'package:breeze/features/history/logic/history_cubit.dart';
import 'package:breeze/features/product_details/logic/product_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  final product = makeProduct(id: 7, price: 19.99, moq: 20, stock: 34);
  late CartCubit cart;
  late ProductDetailsCubit cubit;

  ProductDetailsCubit build() => ProductDetailsCubit(
        FakeProductRepository(),
        cart,
        HistoryCubit(),
        productId: 7,
        initial: product,
      );

  setUp(() {
    cart = CartCubit();
    cubit = build();
  });
  tearDown(() async {
    await cubit.close();
    await cart.close();
  });

  test('quantity starts at the minimum order quantity', () {
    expect(cubit.state.quantity, 20);
    expect(cubit.state.totalPrice, closeTo(399.8, 0.0001));
  });

  test('quantity is clamped between MOQ and stock', () {
    cubit.decrement();
    expect(cubit.state.quantity, 20);
    for (var i = 0; i < 30; i++) {
      cubit.increment();
    }
    expect(cubit.state.quantity, 34);
  });

  test('addToBag updates the cart and shows the success state', () {
    cubit.addToBag();
    expect(cart.state.quantityOf(7), 20);
    expect(cubit.state.added, isTrue);
  });

  test('changing the quantity resets the success state', () {
    cubit.addToBag();
    cubit.increment();
    expect(cubit.state.added, isFalse);
  });

  test('a product already in the bag opens in the added state', () async {
    cart.add(product);
    final other = build();
    expect(other.state.added, isTrue);
    expect(other.state.cartQuantity, 20);
    await other.close();
  });

  test('cart changes are synced live', () async {
    cart.add(product);
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.cartQuantity, 20);
    cart.remove(7);
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.cartQuantity, 0);
    expect(cubit.state.added, isFalse);
  });

  group('quantity when the product is already in the bag', () {
    test('selector opens with the quantity already in the bag', () async {
      cart.setQuantity(product, 25);
      final other = build();
      expect(other.state.quantity, 25);
      expect(other.state.added, isTrue);
      await other.close();
    });

    test('addToBag sets the final quantity, it does not add on top', () async {
      cart.add(product); // 20 in the bag
      final other = build();
      other.increment(); // 21
      other.addToBag();
      expect(cart.state.quantityOf(7), 21); // not 34 (20 + 21 clamped)
      expect(other.state.added, isTrue);
      await other.close();
    });

    test('can lower the quantity back to the MOQ', () async {
      cart.setQuantity(product, 30);
      final other = build();
      for (var i = 0; i < 15; i++) {
        other.decrement();
      }
      expect(other.state.quantity, 20);
      other.addToBag();
      expect(cart.state.quantityOf(7), 20);
      await other.close();
    });

    test('bag changes from another screen update the selector', () async {
      cart.setQuantity(product, 20);
      final other = build();
      cart.setQuantity(product, 28);
      await Future<void>.delayed(Duration.zero);
      expect(other.state.quantity, 28);
      cart.remove(7);
      await Future<void>.delayed(Duration.zero);
      expect(other.state.quantity, 20); // back to MOQ
      expect(other.state.added, isFalse);
      await other.close();
    });
  });
}
