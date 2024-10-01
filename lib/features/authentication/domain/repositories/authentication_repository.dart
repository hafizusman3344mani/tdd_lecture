 import 'package:tdd_lecture/core/utils/typedef.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  ResultVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
