import 'dart:io';
import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:dio/dio.dart';

/// One function to rule them all — convert *any* error to your Failure
Failure mapFailure(Object error) {
  if (error is Failure) return error; // already mapped upstream
  if (error is DioException) return _mapDioException(error);
  return const GenericFailure('Unexpected error');
}

/// Transport/network level mapping (timeouts, no internet, TLS, etc.)
Failure _mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const TimeoutFailure();

    case DioExceptionType.connectionError:
      // Often SocketException: no internet / DNS / airplane mode
      if (e.error is SocketException) {
        return const NetworkFailure(message: 'Connection error');
      }
      return NetworkFailure(message: 'Connection error', statusCode: e.response?.statusCode);

    case DioExceptionType.badCertificate:
      return const GenericFailure('Bad certificate');

    case DioExceptionType.cancel:
      return const GenericFailure('Request cancelled');

    case DioExceptionType.badResponse:
      final sc = e.response?.statusCode;
      if (sc == 401) return const UnauthorizedFailure();
      if (sc == 404) return const NotFoundFailure();
      if (sc == 408) return const TimeoutFailure();
      // 4xx as validation by default (tweak if your API differs)
      if (sc != null && sc >= 400 && sc < 500) {
        final msg = _extractMessage(e.response?.data) ?? 'Validation error';
        return ValidationFailure(msg);
      }
      return NetworkFailure(
        statusCode: sc,
        message: e.message ?? 'HTTP error',
      );

    case DioExceptionType.unknown:
      // Could still be SocketException on some platforms
      if (e.error is SocketException) {
        return const NetworkFailure(message: 'Connection error');
      }
      return GenericFailure(e.message ?? 'Unknown network error');
  }
}

/// Backend/business-level mapping from your envelope (code/message/data).
/// Adjust the code rules to your API contract.
Failure mapBackendError({int? code, String? message, Object? body}) {
  // Common conventions — tune as needed:
  if (code == 401) return const UnauthorizedFailure();
  if (code == 404) return const NotFoundFailure();
  if (code == 408) return const TimeoutFailure();
  if (code != null && code >= 400 && code < 500) {
    return ValidationFailure(message ?? 'Validation error');
  }
  if (code != null && code >= 500) {
    return NetworkFailure(statusCode: code, message: message ?? 'Server error');
  }
  // Fallback (unknown code)
  return GenericFailure(message ?? 'Backend error');
}

/// Try to pull a "message" field from a response body
String? _extractMessage(Object? data) {
  if (data is Map && data['message'] != null) return data['message']?.toString();
  return null;
}
