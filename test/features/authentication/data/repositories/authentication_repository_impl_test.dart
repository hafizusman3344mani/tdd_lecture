import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_lecture/core/errors/exceptions.dart';
import 'package:tdd_lecture/core/errors/failure.dart';
import 'package:tdd_lecture/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_lecture/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource dataSource;
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
        authenticationRemoteDataSource: dataSource);
  });
  const tException =
      ApiException(message: 'Something went wrong', statusCode: 500);
  group('createUser', () {
    const name = 'empty.name';
    const createdAt = 'empty.createdAt';
    const avatar = 'empty.avatar';

    test(
        'should call [AuthenticationRemoteDataSource.createUser] and return success',
        () async {
      //Arrange
      when(() => dataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          )).thenAnswer((_) async => Future.value());

      //Act
      final result = await authenticationRepositoryImpl.createUser(
          name: name, createdAt: createdAt, avatar: avatar);

      //Assert

      expect(result, equals(const Right(null)));

      verify(() => dataSource.createUser(
          name: name, createdAt: createdAt, avatar: avatar)).called(1);

      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should throw [ApiException] when [AuthenticationRemoteDataSource.createUser] unsuccessful',
        () async {
      //Arrange
      when(() => dataSource.createUser(
          name: name,
          createdAt: createdAt,
          avatar: avatar)).thenThrow(tException);

      //Act

      final result = await authenticationRepositoryImpl.createUser(
          name: name, createdAt: createdAt, avatar: avatar);

      //Assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(
              message: tException.message,
              errorCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(() => dataSource.createUser(
          name: name, createdAt: createdAt, avatar: avatar)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('getUsers', () {
    test('should return [List<User>] when [RemoteDataSource.getUsers] called',
        () async {
      // Arrange
      when(() => dataSource.getUsers()).thenAnswer((_) async => []);

      // Act
      final result = await authenticationRepositoryImpl.getUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should throw [ApiException] when [AuthenticationRemoteDataSource.getUsers] unsuccessful',
        () async {
      // Arrange
      when(() => dataSource.getUsers()).thenThrow(tException);

      //Act
      final result = await authenticationRepositoryImpl.getUsers();

      //Assert
      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
