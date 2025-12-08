import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String get toIDR {
    // 1. Create a NumberFormat for Indonesian Locale
    // 'decimalDigits: 0' ensures we don't get ,00 at the end
    // 'symbol: 'Rp.'' sets the prefix
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    // 2. Format the current double value
    return format.format(this);
  }
}
