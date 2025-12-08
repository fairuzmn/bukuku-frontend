typedef JsonMap = Map<String, dynamic>;
typedef JsonDecoder<T> = T Function(JsonMap json);

class RestResponse<T> {
  final int? code;
  final String? message;
  final T? data;

  const RestResponse({this.code, this.message, this.data});

  bool get isSuccess => code == 200;

  factory RestResponse.fromJson(
    JsonMap json,
    JsonDecoder<T> decoder,
  ) {
    final raw = json['data'];

    final T? parsed = switch (raw) {
      null => null,
      Map<String, dynamic> m => decoder(m),
      Map m => decoder(Map<String, dynamic>.from(m)),
      _ => throw StateError('Expected object for "data", got ${raw.runtimeType}'),
    };

    return RestResponse<T>(
      code: json['code'],
      message: json['message'],
      data: parsed,
    );
  }
}
