import 'package:bukuku_frontend/core/platform/device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderInterceptor extends Interceptor {
  const HeaderInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get local time with timezone offset
    final now = DateTime.now();
    final offset = now.timeZoneOffset;

    final sign = offset.isNegative ? '-' : '+';
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');

    final timestamp = "${DateFormat("yyyy-MM-ddTHH:mm:ss").format(now)}$sign$hours:$minutes";

    options.headers['Accept'] = 'application/json';
    options.headers['X-Timestamp'] = timestamp;
    options.headers['X-Device-ID'] = Get.find<DeviceInfo>().uuid;
    options.headers['X-APP-VERSION'] = Get.find<DeviceInfo>().version;

    super.onRequest(options, handler);
  }
}
