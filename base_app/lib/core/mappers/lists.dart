import 'package:flutter/foundation.dart';

List<T> coreMappersParseList<T>(
  List<dynamic> data,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return data.map<T>((e) => fromJson(e as Map<String, dynamic>)).toList();
  } catch (e, _) {
    if (kDebugMode) {
      print(e);
      print(_);
    }
    rethrow;
  }
}
