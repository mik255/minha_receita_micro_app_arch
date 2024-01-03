import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';

extension CommonContextExtensons on BuildContext {
  void commonExtensionsShowDSModal({
    Widget? content,
    bool withScroll = true,
    Widget? customContent,
  }) {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return customContent ??
            DSModal(
              content: content,
              withScroll: withScroll,
            );
      },
    );
  }
}
