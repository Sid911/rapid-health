import 'package:flutter/material.dart';
import 'package:rapid_health/global/logo_mini.dart';
import 'package:rapid_health/pages/login/user_switcher.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.settingsService}) : super(key: key);
  final SettingsService settingsService;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SettingsService settings;
  bool userIsPatient = true;

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
    final ThemeData theme = Theme.of(context);
    final typography =
        settings.darkMode ? theme.typography.white : theme.typography.black;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(text: "Your ", children: <TextSpan>[
                              TextSpan(
                                text: "health",
                                style: theme.textTheme.headline3,
                              ),
                            ]),
                            style: theme.textTheme.headline2,
                          ),
                          Text.rich(
                            TextSpan(text: "Closer to ", children: <TextSpan>[
                              TextSpan(
                                text: "You",
                                style: theme.textTheme.headline2,
                              ),
                            ]),
                            style: theme.textTheme.headline3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: LogoMini(darkMode: settings.darkMode),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginUserSwitcher(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 300,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
