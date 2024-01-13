class CoreResponse {
  final int? statusCode;
  final dynamic data;
  final Map<String, dynamic> headers;

  CoreResponse({
    required this.statusCode,
    required this.data,
    required this.headers,
  });
}
