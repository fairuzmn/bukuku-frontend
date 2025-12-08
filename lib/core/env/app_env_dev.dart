import 'package:envied/envied.dart';
import 'app_env.dart';

part 'app_env_dev.g.dart';

@Envied(path: '.env.dev', obfuscate: true)
class AppEnvDev implements AppEnv {
  @override
  String get name => "DEV";

  @override
  @EnviedField(varName: 'BASE_API_URL')
  final String baseApiUrl = _AppEnvDev.baseApiUrl;
}
