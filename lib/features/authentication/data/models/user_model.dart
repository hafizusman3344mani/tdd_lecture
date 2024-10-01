import 'dart:convert';

import 'package:tdd_lecture/features/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  const UserModel.empty() : super.empty();

  factory UserModel.decodeToMap(String source) =>
      UserModel.fromJson(jsonDecode(source));

  factory UserModel.fromJson(DataMap map) => UserModel(
        id: map['id'] as String,
        name: map['name'] as String,
        createdAt: map['createdAt'] as String,
        avatar: map['avatar'] as String,
      );

  UserModel copyWith(
          {String? id, String? name, String? createdAt, String? avatar}) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        avatar: avatar ?? this.avatar,
      );

  DataMap toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'avatar': avatar,
      };

  String encodeJson() => jsonEncode(toJson());
}
