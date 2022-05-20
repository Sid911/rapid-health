import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_cubit.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/pages/homepage/patient_homepage.dart';
import 'package:rapid_health/pages/login/login_page.dart';
import 'package:rapid_health/pages/registration/registration_page.dart';
import 'package:rapid_health/pages/setup/setup_page.dart';
import 'package:rapid_health/services/chatStorageService/local_chat_service_impl.dart';
import 'package:rapid_health/services/loginService/local_auth_service_impl.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/custom_colors.dart';
import 'package:rapid_health/utility/local_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  LocalServer.init();
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
        return MultiProvider(
          providers: [
            Provider<AuthServiceInterface>(create: (_) => LocalAuthService()),
            Provider<ChatServiceInterface>(create: (_) => LocalChatService())
          ],
          child: MaterialApp(
            title: 'Rapid Health',
            debugShowCheckedModeBanner: false,
            themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: themes.lightTheme,
            darkTheme: themes.darkTheme,
            routes: {
              "home": (ctx) => Homepage(settingsService: settings),
              "login": (ctx) => BlocProvider(
                    create: (context) => LoginUICubit(
                      authService: context.read<AuthServiceInterface>(),
                    ),
                    child: LoginPage(settingsService: settings),
                  ),
              "setup": (ctx) => SetupPage(settingsService: settings),
              "register": (ctx) => const RegistrationPage(),
            },
            initialRoute: "login",
          ),
        );
      },
    );
  }
}
