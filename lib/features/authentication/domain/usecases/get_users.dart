import 'package:tdd_lecture/core/usecase/usecase.dart';
import 'package:tdd_lecture/core/utils/typedef.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';
import 'package:tdd_lecture/features/authentication/domain/repositories/authentication_repository.dart';

class GetUsers implements UseCaseWithOutParams<List<User>> {
  final AuthenticationRepository authenticationRepository;

  GetUsers({required this.authenticationRepository});
  @override
  ResultFuture<List<User>> call() async {
    return await authenticationRepository.getUsers();
  }
}
