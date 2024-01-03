import 'package:flutter/foundation.dart';

extension CoreExtensionGetMapList on dynamic {
  List<T> getListMap<T>() {
    try {
      return map((e) => (T as dynamic).fromJson(e) as T).toList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print(stackTrace);
      }
      rethrow;
    }
  }
}
