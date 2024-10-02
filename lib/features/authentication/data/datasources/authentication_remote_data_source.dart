import 'package:tdd_lecture/core/constants/end_points.dart';
import 'package:tdd_lecture/core/networking/dio_client.dart';
import 'package:tdd_lecture/features/authentication/data/models/user_model.dart';

abstract interface class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String createdAt,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final DioClient dioClient;

  AuthenticationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> createUser(
      {required String name,
      required String createdAt,
      required String avatar}) async {
    try {
      final response = await dioClient.post(
        EndPoints.users,
        data: {
          'name': name,
          'createdAt': createdAt,
          'avatar': avatar,
        },
      );
      print(response.statusCode);
      print(response.data);
    } catch (e) {
      print(e);
      print(e.runtimeType);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try{
      final response = await dioClient.get(EndPoints.users);
      print(response.statusCode);
      print(response.data);
      return [];
    }catch (e) {
      print(e);
      print(e.runtimeType);
      return [];
    }
  }
}
