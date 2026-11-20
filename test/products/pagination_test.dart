import 'package:breeze/core/utils/pagination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('few pages: all numbers', () {
    expect(buildPageWindow(1, 3), [1, 2, 3]);
  });
  test('start: 1 2 3 ... last', () {
    expect(buildPageWindow(1, 10), [1, 2, 3, null, 10]);
  });
  test('middle: 1 ... current ... last', () {
    expect(buildPageWindow(5, 10), [1, null, 5, null, 10]);
  });
  test('end: 1 ... last three', () {
    expect(buildPageWindow(10, 10), [1, null, 8, 9, 10]);
  });
}
