import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_lecture/core/utils/typedef.dart';
import 'package:tdd_lecture/features/authentication/data/models/user_model.dart';
import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel.empty();

  test('should be subclass of [User] entity', () {
    //Assert
    expect(tUserModel, isA<User>());
  });

  final tJson = fixtureReader('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      //Act
      final result = UserModel.fromJson(tMap);

      //Assert
      expect(result, tUserModel);
    });
  });

  group('decodeToMap', () {
    test('should return a [UserModel] with the right data', () {
      //Act
      final result = UserModel.decodeToMap(tJson);

      //Assert
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a [MapData] with the right data', () {
      //Act
      final result = tUserModel.toJson();

      //Assert
      expect(result, tMap);
    });
  });

  group('encodeJson', () {
    test('should return a [String] with the right data', () {
      //Arrange
      final newTJson = jsonEncode({
        "id": "1",
        "name": "_empty.name",
        "createdAt": "_empty.createdAt",
        "avatar": "_empty.avatar"
      });

      //Act
      final result = tUserModel.encodeJson();

      //Assert
      expect(result, newTJson);
    });
  });

  group('copyWith', () {
    test('should return [UserModel] with changed data', () {
      //Arrange

      //Act
      final result = tUserModel.copyWith(name: 'Usman');

      //Assert
      expect(result.name, equals('Usman'));
    });
  });
}
