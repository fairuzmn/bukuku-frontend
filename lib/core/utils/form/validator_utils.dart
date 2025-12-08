class ValidatorUtils {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return "Required";
    return null;
  }

  static String? min(String? v, int n) {
    if (v == null || v.length < n) return "Min $n chars";
    return null;
  }

  static String? max(String? v, int n) {
    if (v != null && v.length > n) return "Max $n chars";
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return "Required";
    final r = RegExp(r"^[\w\.\-]+@[\w\.\-]+\.\w+$");
    if (!r.hasMatch(v)) return "Invalid email";
    return null;
  }

  static String? numeric(String? v) {
    if (v == null || v.trim().isEmpty) return "Required";
    if (double.tryParse(v) == null) return "Invalid number";
    return null;
  }

  static String? match(String? a, String? b) {
    if (a != b) return "Not match";
    return null;
  }

  static String? rangeNum(String? v, num min, num max) {
    if (v == null) return "Required";
    final n = num.tryParse(v);
    if (n == null) return "Invalid number";
    if (n < min || n > max) return "Out of range";
    return null;
  }
}

class ValidatorChain {
  final String? _value;
  String? _error;

  ValidatorChain(this._value);

  ValidatorChain required() {
    _error ??= ValidatorUtils.required(_value);
    return this;
  }

  ValidatorChain email() {
    _error ??= ValidatorUtils.email(_value);
    return this;
  }

  ValidatorChain min(int n) {
    _error ??= ValidatorUtils.min(_value, n);
    return this;
  }

  ValidatorChain max(int n) {
    _error ??= ValidatorUtils.max(_value, n);
    return this;
  }

  ValidatorChain numeric() {
    _error ??= ValidatorUtils.numeric(_value);
    return this;
  }

  ValidatorChain rangeNum(num min, num max) {
    _error ??= ValidatorUtils.rangeNum(_value, min, max);
    return this;
  }

  String? result() => _error;
}

extension ValidatorUtilsChainExt on ValidatorUtils {
  static ValidatorChain chain(String? v) => ValidatorChain(v);
}

