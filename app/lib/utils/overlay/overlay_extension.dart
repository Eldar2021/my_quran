import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension OverlayExtension on BuildContext {
  void manageLoader(bool isLoading) {
    if (isLoading && !loaderOverlay.visible) {
      loaderOverlay.show();
    } else if (!isLoading && loaderOverlay.visible) {
      loaderOverlay.hide();
    }
  }
}
