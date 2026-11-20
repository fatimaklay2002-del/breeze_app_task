import 'dart:io';
import 'package:dio/dio.dart';

enum FailureType { network, timeout, server, parsing, cancelled, unknown }

class Failure implements Exception {
  final FailureType type;
  final String message;

  const Failure(this.type, this.message);

  bool get isCancelled => type == FailureType.cancelled;

  factory Failure.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        return const Failure(FailureType.cancelled, 'Request cancelled');
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure(FailureType.timeout,
            'The connection is too slow or timed out. Check your internet and try again.');
      case DioExceptionType.connectionError:
        return const Failure(FailureType.network,
            'No internet connection. Check your network and try again.');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 404) {
          return const Failure(
              FailureType.server, 'This product could not be found.');
        }
        if (code != null && code >= 500) {
          return const Failure(FailureType.server,
              'The server is having problems. Please try again later.');
        }
        return Failure(FailureType.server,
            'Request failed (${code ?? '-'}). Please try again.');
      default:
        if (e.error is SocketException) {
          return const Failure(FailureType.network,
              'No internet connection. Check your network and try again.');
        }
        return const Failure(
            FailureType.unknown, 'Something went wrong. Please try again.');
    }
  }

  @override
  String toString() => message;
}
