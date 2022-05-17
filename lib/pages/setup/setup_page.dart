import 'package:flutter/material.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({Key? key, required this.settingsService}) : super(key: key);
  final SettingsService settingsService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Text("Setup Page"),
        ),
      ),
    );
  }
}
