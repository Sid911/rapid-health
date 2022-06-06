import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_cubit.dart';
import 'package:rapid_health/bloc/registration/registration_cubit.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/interfaces/search_service_interface.dart';
import 'package:rapid_health/pages/bookings/bookings.dart';
import 'package:rapid_health/pages/chat/chat_page.dart';
import 'package:rapid_health/pages/homepage/homepage.dart';
import 'package:rapid_health/pages/login/login_page.dart';
import 'package:rapid_health/pages/post_editor/post_editor.dart';
import 'package:rapid_health/pages/registration/registration_page.dart';
import 'package:rapid_health/pages/setup/setup_page.dart';
import 'package:rapid_health/services/bookingStorageService/local_booking_storage_service.dart';
import 'package:rapid_health/services/chatStorageService/local_chat_service_impl.dart';
import 'package:rapid_health/services/loginService/local_auth_service_impl.dart';
import 'package:rapid_health/services/postStorageService/local_posts_service_impl.dart';
import 'package:rapid_health/services/searchService/local_search_service_impl.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/custom_colors.dart';
import 'package:rapid_health/utility/local_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await LocalServer.init();
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
  final authService = LocalAuthService();
  final Logger _logger = Logger();
  late bool newUser;

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    // Jank way of persistence
    newUser = !settings.loggedInBefore;
    if (!newUser) {
      _logger.i(
        "Refreshing Auth manager with "
        "\nEmail: ${settings.loginEmail}"
        "\nPassword: ${settings.loginPassword}",
      );
      if (settings.isUserDoctor) {
        authService.loginDoctorWithEmailPassword(
          email: settings.loginEmail,
          password: settings.loginPassword,
        );
      } else {
        authService.loginPatientWithEmailPassword(
          email: settings.loginEmail,
          password: settings.loginPassword,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Themes themes = Themes();
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context, box, _) {
        return MultiProvider(
          providers: [
            Provider<AuthServiceInterface>(create: (_) => authService),
            Provider<ChatServiceInterface>(create: (_) => LocalChatService()),
            Provider<PostsServiceInterface>(create: (_) => LocalPostsService()),
            Provider<SearchServiceInterface>(
              create: (_) => LocalSearchService(),
            ),
            Provider<BookingServiceInterface>(
              create: (_) => LocalBookingService(),
            ),
            Provider<ChatServiceInterface>(create: (_) => LocalChatService()),
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
              "register": (ctx) => BlocProvider(
                    create: (context) => RegistrationCubit(
                      authService: context.read<AuthServiceInterface>(),
                    ),
                    child: const RegistrationPage(),
                  ),
              "newPost": (ctx) => const PostEditor(),
              "bookings": (ctx) => const BookingsPage(),
              "chats": (ctx) => const ChatPage(),
            },
            initialRoute: newUser ? "login" : "home",
          ),
        );
      },
    );
  }
}
