import 'package:dio/dio.dart';
import 'failures.dart';

const _parsingMessage =
    'We received unexpected data from the server. Please try again.';

/// The only place that knows about Dio errors: everything becomes a Failure.
Future<T> guardRequest<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw Failure.fromDio(e);
  } on TypeError {
    throw const Failure(FailureType.parsing, _parsingMessage);
  } on FormatException {
    throw const Failure(FailureType.parsing, _parsingMessage);
  } catch (_) {
    throw const Failure(
        FailureType.unknown, 'Something went wrong. Please try again.');
  }
}
