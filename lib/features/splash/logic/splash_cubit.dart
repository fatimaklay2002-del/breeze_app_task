import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/failures.dart';
import '../../products/data/repository/product_repository.dart';

enum SplashStatus { loading, ready }

class SplashCubit extends Cubit<SplashStatus> {
  final ProductRepository _repo;
  SplashCubit(this._repo) : super(SplashStatus.loading);

  static const _minDuration = Duration(milliseconds: 1500);

  /// Real initialization: warm up the categories cache while the logo shows.
  Future<void> start() async {
    await Future.wait([Future.delayed(_minDuration), _warmUp()]);
    if (!isClosed) emit(SplashStatus.ready);
  }

  Future<void> _warmUp() async {
    try {
      await _repo.getCategories();
    } on Failure {
      // Not fatal: the Browse screen shows its own retry for categories.
    }
  }
}
