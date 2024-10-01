import 'package:dartz/dartz.dart';
import 'package:tdd_lecture/core/errors/exceptions.dart';
import 'package:tdd_lecture/core/errors/failure.dart';
import 'package:tdd_lecture/core/utils/typedef.dart';
import 'package:tdd_lecture/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';
import 'package:tdd_lecture/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImpl({required this.authenticationRemoteDataSource});
  @override
  ResultVoid createUser(
      {required String name,
      required String createdAt,
      required String avatar}) async {
    try {
      await authenticationRemoteDataSource.createUser(
          name: name, createdAt: createdAt, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await authenticationRemoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
