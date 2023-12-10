import 'package:flutter/material.dart';

import '../../../design_system/modals_contents/default_modal.dart';

extension CoreContextExtensons on BuildContext {
  void coreExtensionsShowDSModal(
      {required Widget content, bool withScroll = true}) {
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
        return DSModal(
          content: content,
          withScroll: withScroll,
        );
      },
    );
  }
}
