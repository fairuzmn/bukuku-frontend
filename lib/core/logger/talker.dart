import 'package:talker_flutter/talker_flutter.dart';
import 'logger.dart';

final Talker talker = TalkerFlutter.init();
final TalkerLogger talkerLogger = TalkerLogger();

class TalkerLoggerX implements Logger {
  @override
  void error(dynamic e, StackTrace? t) {
    talkerLogger.critical(e);

    if (t != null) talkerLogger.critical(t);
  }

  @override
  void log(msg) {
    talkerLogger.info(msg);
  }
}
