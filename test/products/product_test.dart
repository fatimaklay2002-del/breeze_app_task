import 'package:breeze/features/products/data/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  group('pricing', () {
    test('originalPrice = price / (1 - discount/100)', () {
      final p = makeProduct(price: 9, discount: 10);
      expect(p.originalPrice, closeTo(10, 0.0001));
      expect(p.savedAmount, closeTo(1, 0.0001));
      expect(p.discountRounded, 10);
    });

    test('100% discount does not divide by zero', () {
      final p = makeProduct(price: 5, discount: 100);
      expect(p.originalPrice, 5);
    });

    test('no discount -> same price, no discount flag', () {
      final p = makeProduct(price: 12.5);
      expect(p.hasDiscount, isFalse);
      expect(p.originalPrice, closeTo(12.5, 0.0001));
    });
  });

  group('null safety', () {
    test('a nearly empty json does not throw', () {
      final p = Product.fromJson({'id': 1});
      expect(p.hasBrand, isFalse);
      expect(p.brand, isNull);
      expect(p.sku, '-');
      expect(p.images, isEmpty);
      expect(p.minimumOrderQuantity, 1);
    });

    test('int values from the API become double', () {
      final p = Product.fromJson({'id': 1, 'price': 20, 'rating': 4});
      expect(p.price, isA<double>());
      expect(p.rating, 4.0);
    });

    test('blank brand is treated as missing', () {
      expect(makeProduct(brand: '  ').hasBrand, isFalse);
      expect(makeProduct(brand: 'Essence').hasBrand, isTrue);
    });
  });

  group('availability', () {
    test('out of stock', () {
      final p = makeProduct(stock: 0);
      expect(p.unavailableReason, 'Out of stock');
      expect(p.canBeOrdered, isFalse);
    });

    test('minimum order larger than stock', () {
      final p = makeProduct(stock: 5, moq: 20);
      expect(p.canBeOrdered, isFalse);
    });
  });

  test('category label is readable', () {
    expect(makeProduct(category: 'mens-shirts').categoryLabel, 'Mens Shirts');
    expect(makeProduct(category: 'beauty').categoryLabel, 'Beauty');
  });
}
