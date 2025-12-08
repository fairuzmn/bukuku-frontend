import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/session/session_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  final List<String> _guestEndpoint = const [
    Endpoints.login,
    Endpoints.verifyOtp,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_guestEndpoint.contains(options.path)) handler.next(options);

    var currentUser = Get.find<SessionController>().user.value;
    if (currentUser != null) {
      final token = currentUser.accessToken;
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
