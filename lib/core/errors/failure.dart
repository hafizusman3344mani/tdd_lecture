import 'package:equatable/equatable.dart';
import 'package:tdd_lecture/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int errorCode;

  const Failure({
    required this.message,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    required super.errorCode,
  });

  factory ApiFailure.fromException(ApiException exception){
    return ApiFailure(message: exception.message, errorCode: exception.statusCode);
  }
}
