import 'package:bukuku_frontend/core/network/rest_response.dart';

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  JsonMap toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
