import 'package:bukuku_frontend/core/network/rest_response.dart';

class UserEntity {
  final String name;
  final String email;
  final String accessToken;

  const UserEntity({
    required this.name,
    required this.email,
    required this.accessToken,
  });

  factory UserEntity.fromJson(JsonMap json, {String? accessToken}) {
    return UserEntity(
      name: json['name'],
      email: json['email'],
      accessToken: accessToken ?? json['accessToken'],
    );
  }

  JsonMap toJson() {
    return {
      "name": name,
      "email": email,
      "accessToken": accessToken,
    };
  }
}
