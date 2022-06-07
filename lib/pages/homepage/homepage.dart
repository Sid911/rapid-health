import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/global/logo_mini.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/pages/drawer/drawer.dart';
import 'package:rapid_health/pages/homepage/recent_chats_mini.dart';
import 'package:rapid_health/pages/homepage/services_category_mini.dart';
import 'package:rapid_health/pages/search/search_page.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';

import 'bookings_mini_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.settingsService}) : super(key: key);
  final SettingsService settingsService;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SettingsService settings;

  bool rebuildBookings = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    settings = widget.settingsService;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = context.read<AuthServiceInterface>();
    final currentUser = authService.currentUser?.userData;
    return Scaffold(
      extendBody: true,
      primary: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: Hero(
              tag: "search",
              child: Icon(
                settings.darkMode
                    ? FlutterRemix.search_2_line
                    : FlutterRemix.search_2_fill,
                size: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              settings.darkMode = !settings.darkMode;
            },
            icon: Icon(
              settings.darkMode
                  ? FlutterRemix.contrast_2_line
                  : FlutterRemix.contrast_2_fill,
            ),
            tooltip: "Toggle DarkMode",
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: const Icon(FlutterRemix.logout_box_line),
            tooltip: "Logout",
          ),
        ],
        backgroundColor: Colors.transparent,
        leading: Builder(builder: (context) {
          return MaterialButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: LogoMini(
              darkMode: theme.brightness == Brightness.dark,
            ),
          );
        }),
        leadingWidth: 80,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text: "Hi, there ",
                    children: [
                      TextSpan(
                        text: currentUser == null ? "" : currentUser.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  style: theme.textTheme.bodyText1,
                ),
              ),
              const BookingsMini(),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  "Services",
                  style: theme.textTheme.headline4,
                ),
              ),
              const ServicesCategoryMini(),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  "Recent Chats",
                  style: theme.textTheme.headline4,
                ),
              ),
              const RecentChatsMini()
            ],
          ),
        ),
      ),
    );
  }
}
