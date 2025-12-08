import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  String uuid = "";
  String version = "";

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    uuid = await FlutterUdid.consistentUdid;
    version = packageInfo.version;
  }
}
