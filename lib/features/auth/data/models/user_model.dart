import 'package:chugli/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.username, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'], username: json['username'], email: json['email']);
  }
}
