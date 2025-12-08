import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  factory Failure.message(String message) => GenericFailure(message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  final int? statusCode;

  const NetworkFailure({String message = 'Network error', this.statusCode}) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String message = 'Unauthorized'}) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'Not found'}) : super(message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({String message = 'Request timed out'}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}
