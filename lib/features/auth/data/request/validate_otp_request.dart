import 'package:bukuku_frontend/core/network/rest_response.dart';

class ValidateOtpRequest {
  final String email;
  final String otp;

  const ValidateOtpRequest({
    required this.email,
    required this.otp,
  });

  JsonMap toJson() {
    return {
      "email": email,
      "otp": otp,
    };
  }
}
