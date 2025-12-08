import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/auth/domain/entity/user.dart';

class ValidateOtpResponse {
  final UserEntity user;
  final String token;

  const ValidateOtpResponse({
    required this.user,
    required this.token,
  });

  factory ValidateOtpResponse.fromJson(JsonMap json) {
    return ValidateOtpResponse(
      user: UserEntity.fromJson(json['user'], accessToken: json['token']),
      token: json['token'],
    );
  }
}
