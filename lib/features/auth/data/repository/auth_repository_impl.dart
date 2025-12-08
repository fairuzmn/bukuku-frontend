import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/auth/data/request/login_request.dart';
import 'package:bukuku_frontend/features/auth/data/request/validate_otp_request.dart';
import 'package:bukuku_frontend/features/auth/data/response/validate_otp_response.dart';
import 'package:bukuku_frontend/features/auth/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dioClient;

  const AuthRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse>> login(LoginRequest request) async {
    try {
      final res = await dioClient.postRequest(
        Endpoints.login,
        body: request.toJson(),
        decoder: (json) {},
      );

      return Right(res);
    } catch (e, t) {
      print(e);
      print(t);
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<ValidateOtpResponse>>> validateOtp(ValidateOtpRequest request) async {
    try {
      final res = await dioClient.postRequest(
        Endpoints.verifyOtp,
        body: request.toJson(),
        decoder: (json) => ValidateOtpResponse.fromJson(json),
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
