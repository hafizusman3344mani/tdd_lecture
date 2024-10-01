// What does the class depend on?
// Answer -- AuthenticationRepository
// How to create the fake version of the dependency?
// Answer -- Use Mocktail.
// How do we control what our dependencies do?
// Answer -- Using the mocktail's APIs.

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';
import 'package:tdd_lecture/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_lecture/features/authentication/domain/usecases/get_users.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late GetUsers getUsers;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    getUsers = GetUsers(authenticationRepository: repository);
  });
  const tResponse = [User.empty()];
  test('should return List<User> when [repository.getUsers] called', () async {
    //Arrange
    when(() => repository.getUsers())
        .thenAnswer((v) async => const Right(tResponse));

    //Act
    final result = await getUsers();

    //Assert
    expect(result, equals(const Right(tResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
