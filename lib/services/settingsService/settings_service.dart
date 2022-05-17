import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsService {
  final box = Hive.box("settings");

  bool get darkMode => box.get("darkMode", defaultValue: true);

  set darkMode(bool value) {
    box.put("darkMode", value);
  }

  bool get showAppBar => box.get("showAppBar", defaultValue: false);

  set showAppBar(bool value) {
    box.put("showAppBar", value);
  }

  Object correctVariant({
    Object light = Colors.black,
    Object dark = Colors.white,
  }) {
    return darkMode ? dark : light;
  }
}
