import 'package:flutter/cupertino.dart';

class DSDecorators {

  Decoration gradientOutlineBorder(
      {Color color = const Color(0xFFE5E5E5), double width = 1.0}) {
    return BoxDecoration(
      border: Border.all(
        color: color,
        width: width,
      ),
    );
  }
}
