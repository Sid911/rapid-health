import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

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

  String get loginEmail => box.get("loginEmail", defaultValue: "email");

  String get loginPassword =>
      box.get("loginPassword", defaultValue: "password");

  bool get isUserDoctor => box.get("userDoctor", defaultValue: false);

  bool get loggedInBefore => box.containsKey("login");

  void saveUser(UserData data) {
    box.put("login", true);
    box.put("loginEmail", data.email);
    box.put("loginPassword", data.password);
    box.put("userDoctor", data is DoctorData);
  }

  void resetSettings() {
    box.clear();
  }

  Object correctVariant({
    Object light = Colors.black,
    Object dark = Colors.white,
  }) {
    return darkMode ? dark : light;
  }
}
