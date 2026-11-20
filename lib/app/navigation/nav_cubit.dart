import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTab { home, bag, history, wishlist, settings }

class NavState extends Equatable {
  final AppTab tab;
  final int searchRequests;
  final bool searchFocused;

  const NavState({
    this.tab = AppTab.home,
    this.searchRequests = 0,
    this.searchFocused = false,
  });

  /// "Search" tab is lit while the field is focused or a query is active.
  bool isSearchSelected({required bool hasQuery}) =>
      tab == AppTab.home && (searchFocused || hasQuery);

  /// [item] == null is the Search tab.
  bool isSelected(AppTab? item, {required bool hasQuery}) {
    final search = isSearchSelected(hasQuery: hasQuery);
    return item == null ? search : tab == item && !(item == AppTab.home && search);
  }

  @override
  List<Object?> get props => [tab, searchRequests, searchFocused];
}

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState());

  void select(AppTab tab) =>
      emit(NavState(tab: tab, searchRequests: state.searchRequests));

  void openSearch() => emit(NavState(
        searchRequests: state.searchRequests + 1,
        searchFocused: true,
      ));

  void setSearchFocused(bool focused) {
    if (focused == state.searchFocused) return;
    emit(NavState(
      tab: state.tab,
      searchRequests: state.searchRequests,
      searchFocused: focused,
    ));
  }
}
