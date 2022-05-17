import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rapid_health/pages/homepage/homepage.dart';
import 'package:rapid_health/pages/login/login_page.dart';
import 'package:rapid_health/pages/setup/setup_page.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/custom_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of the application.
  final SettingsService settings = SettingsService();
  @override
  Widget build(BuildContext context) {
    final Themes themes = Themes();
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context, box, _) {
        return MaterialApp(
          title: 'Rapid Health',
          debugShowCheckedModeBanner: false,
          themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: themes.lightTheme,
          darkTheme: themes.darkTheme,
          routes: {
            "home": (ctx) => Homepage(settingsService: settings),
            "login": (ctx) => LoginPage(settingsService: settings),
            "setup": (ctx) => SetupPage(settingsService: settings),
          },
          initialRoute: "home",
        );
      },
    );
  }
}
