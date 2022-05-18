import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/global/logo_mini.dart';
import 'package:rapid_health/pages/drawer/drawer.dart';
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
    return Scaffold(
      extendBody: true,
      primary: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
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
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Home Page"),
              ),
              BookingsMini(),
            ],
          ),
        ),
      ),
    );
  }
}