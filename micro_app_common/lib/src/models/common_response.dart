import 'package:micro_app_core/micro_app_core.dart';

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
