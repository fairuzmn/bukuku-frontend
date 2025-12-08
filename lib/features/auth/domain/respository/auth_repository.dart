import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/auth/data/request/login_request.dart';
import 'package:bukuku_frontend/features/auth/data/request/validate_otp_request.dart';
import 'package:bukuku_frontend/features/auth/data/response/validate_otp_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, RestResponse>> login(LoginRequest request);

  Future<Either<Failure, RestResponse<ValidateOtpResponse>>> validateOtp(ValidateOtpRequest request);
}
