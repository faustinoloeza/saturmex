import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformInfo {
  bool isDesktopOS() {
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }

  bool isAppOS() {
    return Platform.isIOS || Platform.isAndroid;
  }

  bool isWeb() {
    return kIsWeb;
  }

    String getCurrentPlatformType() {
    if (kIsWeb) {
      return "Web";
    }

    if (Platform.isMacOS) {
      return "MacOS";
    }

    if (Platform.isFuchsia) {
      return "Fuchsia";
    }

    if (Platform.isLinux) {
      return "Linux";
    }

    if (Platform.isWindows) {
      return "Windows";
    }

    if (Platform.isIOS) {
      return "iOS";
    }

    if (Platform.isAndroid) {
      return "Android";
    }

    return "Unknown";
  }
}
