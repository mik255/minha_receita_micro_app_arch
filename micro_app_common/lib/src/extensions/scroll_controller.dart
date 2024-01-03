import 'package:flutter/cupertino.dart';

extension CoreExtensionScrollController on ScrollController {
  bool get isAtBottom {
    return position.pixels == position.maxScrollExtent;
  }

  bool get isAtTop {
    return position.pixels == position.minScrollExtent;
  }

  void onBottomListener(VoidCallback callback) {
    addListener(() {
      if (isAtBottom) {
        callback();
      }
    });
  }
}
