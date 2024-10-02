
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_lecture/core/constants/end_points.dart';
import 'package:tdd_lecture/core/errors/exceptions.dart';
import 'package:tdd_lecture/core/networking/dio_client.dart';
import 'package:tdd_lecture/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';

class MockDioClient extends Mock implements DioClient {}

Response mockResponse(String path,
    {required int statusCode, required dynamic data}) {
  return Response(
    requestOptions: RequestOptions(path: path),
    statusCode: statusCode,
    data: data,
  );
}

void main() {
  late DioClient dioClient;
  late AuthenticationRemoteDataSource authenticationRemoteDataSourceImpl;

  setUp(() {
    dioClient = MockDioClient();
    authenticationRemoteDataSourceImpl =
        AuthenticationRemoteDataSourceImpl(dioClient: dioClient);
  });

  group('createUser', () {
    test('should make POST call with correct data', () async {
      // Create a mock response
      final response = Response(
        requestOptions: RequestOptions(path: EndPoints.users),
        statusCode: 200,
      );

      // Arrange
      final userData = {
        'name': 'name',
        'createdAt': 'createdAt',
        'avatar': 'avatar',
      };

      when(() => dioClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => response);

      // Act
      await authenticationRemoteDataSourceImpl.createUser(
          name: 'name', createdAt: 'createdAt', avatar: 'avatar');

      verify(() => dioClient.post(
            EndPoints.users,
            data: userData,
          )).called(1);

      verifyNoMoreInteractions(dioClient);
    });
    test('should make POST call with exception', () async {
      // Arrange
      final userData = {
        'name': 'name',
        'createdAt': 'createdAt',
        'avatar': 'avatar',
      };

      // Mock Dio's post method
      when(() => dioClient.post(any(), data: any(named: 'data')))
          .thenThrow(const ApiException(message: 'message', statusCode: 500));

      // Act
      await authenticationRemoteDataSourceImpl.createUser(
          name: 'name', createdAt: 'createdAt', avatar: 'avatar');

      verify(() => dioClient.post(
            EndPoints.users,
            data: userData,
          )).called(1);

      verifyNoMoreInteractions(dioClient);
    });
  });
  group('getUsers', () {
    test('should make GET call with correct data', () async {
      List<User> users = [];
      final response = Response(
          requestOptions: RequestOptions(path: EndPoints.users),
          statusCode: 200,
          data: []);

      // Mock Dio's post method
      when(() => dioClient.get(
            any(),
          )).thenAnswer((_) async => response);

      // Act
      final result = await authenticationRemoteDataSourceImpl.getUsers();

      expect(result, equals(users));
      verify(() => dioClient.get(
            EndPoints.users,
          )).called(1);

      verifyNoMoreInteractions(dioClient);
    });
    test('should make GET call with exception', () async {
      // Mock Dio's post method
      when(() => dioClient.get(any()))
          .thenThrow(const ApiException(message: 'message', statusCode: 500));

      // Act
      await authenticationRemoteDataSourceImpl.getUsers();

      verify(() => dioClient.get(
            EndPoints.users,
          )).called(1);

      verifyNoMoreInteractions(dioClient);
    });
  });
}
