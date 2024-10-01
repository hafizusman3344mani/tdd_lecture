import 'package:tdd_lecture/features/authentication/data/models/user_model.dart';

abstract interface class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String createdAt,
      required String avatar});

  Future<List<UserModel>> getUsers();
}
