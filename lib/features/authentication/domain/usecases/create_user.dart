import 'package:equatable/equatable.dart';
import 'package:tdd_lecture/core/utils/typedef.dart';
import 'package:tdd_lecture/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/usecase/usecase.dart';

class CreateUser implements UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository authenticationRepository;
  CreateUser({required this.authenticationRepository});

  @override
  ResultVoid call(CreateUserParams params) async {
    return await authenticationRepository.createUser(
      name: params.name,
      createdAt: params.createdAt,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  const CreateUserParams.empty()
      : this(
          name: '_empty.name',
          createdAt: '_empty.createdAt',
          avatar: '_empty.avatar',
        );

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
