import 'package:breeze/app/navigation/nav_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Home is selected by default, Search is not', () {
    const s = NavState();
    expect(s.isSelected(AppTab.home, hasQuery: false), isTrue);
    expect(s.isSelected(null, hasQuery: false), isFalse);
  });

  test('focusing the field or having a query lights Search, not Home', () {
    const focused = NavState(searchFocused: true);
    expect(focused.isSelected(null, hasQuery: false), isTrue);
    expect(focused.isSelected(AppTab.home, hasQuery: false), isFalse);
    const s = NavState();
    expect(s.isSelected(null, hasQuery: true), isTrue);
  });

  test('other tabs never light Search', () {
    const s = NavState(tab: AppTab.bag, searchFocused: true);
    expect(s.isSelected(AppTab.bag, hasQuery: true), isTrue);
    expect(s.isSelected(null, hasQuery: true), isFalse);
  });

  test('select() leaves the search state and bumps nothing', () {
    final cubit = NavCubit()..openSearch();
    expect(cubit.state.searchRequests, 1);
    cubit.select(AppTab.bag);
    expect(cubit.state.tab, AppTab.bag);
    expect(cubit.state.searchFocused, isFalse);
    expect(cubit.state.searchRequests, 1);
    cubit.close();
  });
}
