// What does the class depend on?
// Answer -- AuthenticationRepository
// How to create the fake version of the dependency?
// Answer -- Use Mocktail.
// How do we control what our dependencies do?
// Answer -- Using the mocktail's APIs.

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_lecture/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_lecture/features/authentication/domain/usecases/create_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUser createUser;
  late AuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    createUser =
        CreateUser(authenticationRepository: mockAuthenticationRepository);
  });
  const params = CreateUserParams.empty();
  test('should call [AuthenticationRepository.createUser]', () async {
    // Arrange
    when(() => mockAuthenticationRepository.createUser(
          name: any(named: 'name'),
          createdAt: any(named: 'createdAt'),
          avatar: any(named: 'avatar'),
        )).thenAnswer((_) async => const Right(null));

    //Act
    final result = await createUser(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => mockAuthenticationRepository.createUser(
          name: params.name,
          createdAt: params.createdAt,
          avatar: params.avatar,
        )).called(1);

    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
