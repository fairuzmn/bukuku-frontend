import 'package:bukuku_frontend/core/config/app_config.dart';
import 'package:bukuku_frontend/core/errors/error_mapper.dart';
import 'package:bukuku_frontend/core/errors/exceptions.dart';
import 'package:bukuku_frontend/core/network/interceptors/auth_interceptor.dart';
import 'package:bukuku_frontend/core/network/interceptors/header_interceptor.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef Decoder<T> = JsonDecoder<T>;

class DioClient {
  final Dio _dio;

  DioClient({
    required AppConfig appConfig,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: appConfig.env.baseApiUrl,
           connectTimeout: const Duration(seconds: 20),
           receiveTimeout: const Duration(seconds: 20),
           responseType: ResponseType.json,
           validateStatus: (s) => true,
         ),
       ) {
    _dio.interceptors.addAll([
      HeaderInterceptor(),
      AuthInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    ]);
  }

  Future<RestResponse<T>> getRequest<T>(
    String path, {
    JsonDecoder<T>? decoder,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: query);
      return _parse<T>(res.data, decoder);
    } catch (e, t) {
      print(e);
      print(t);
      throw mapFailure(e);
    }
  }

  Future<RestResponse<T>> postRequest<T>(
    String path, {
    JsonDecoder<T>? decoder,
    Object? body,
  }) async {
    try {
      final res = await _dio.post(path, data: body);
      return _parse<T>(res.data, decoder);
    } catch (e) {
      throw mapFailure(e);
    }
  }

  Future<RestResponse<T>> patchRequest<T>(
    String path, {
    JsonDecoder<T>? decoder,
    Object? body,
  }) async {
    try {
      final res = await _dio.patch(path, data: body);
      return _parse<T>(res.data, decoder);
    } catch (e) {
      throw mapFailure(e);
    }
  }

  Future<RestResponse<T>> deleteRequest<T>(
    String path, {
    JsonDecoder<T>? decoder,
    Map<String, dynamic>? query,
    Object? body,
  }) async {
    try {
      final res = await _dio.delete(path, queryParameters: query, data: body);
      return _parse<T>(res.data, decoder);
    } catch (e) {
      throw mapFailure(e);
    }
  }

  RestResponse<T> _parse<T>(dynamic json, JsonDecoder<T>? decoder) {
    if (json is! Map) {
      throw ParsingException("Root must be JSON object");
    }

    final map = Map<String, dynamic>.from(json);

    final code = map['code'] as int?;
    final message = map['message']?.toString();

    if (code == null || code != 200) {
      throw mapBackendError(
        code: code,
        message: message,
        body: map,
      );
    }

    return RestResponse<T>.fromJson(
      map,
      decoder ?? _noDecode<T>,
    );
  }

  T _noDecode<T>(JsonMap _) => null as T;
}
