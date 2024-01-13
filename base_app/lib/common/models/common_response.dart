import '../../core/http/core_response.dart';

class CommonResponse implements CoreResponse {
  @override
  final int? statusCode;
  @override
  final dynamic data;
  @override
  final Map<String, dynamic> headers;

  CommonResponse({
    required this.statusCode,
    required this.data,
    required this.headers,
  });
}
