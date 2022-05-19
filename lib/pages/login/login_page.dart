import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_cubit.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_state.dart';
import 'package:rapid_health/global/logo_mini.dart';
import 'package:rapid_health/pages/login/user_switcher.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/streamable_text_model.dart';

import 'login_card.dart';

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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Animation<double> translateAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    settings = widget.settingsService;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    translateAnimation = Tween<double>(begin: 250, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final snackBar = const SnackBar(
    content: Text('Error! During Login ? Are you sure you have an account.'),
  );
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Row(
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
                                TextSpan(
                                  text: "Your ",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "health",
                                      style: theme.textTheme.headline3,
                                    ),
                                  ],
                                ),
                                style: theme.textTheme.headline2,
                              ),
                              Text.rich(
                                TextSpan(
                                    text: "Closer to ",
                                    children: <TextSpan>[
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
                        child: LogoMini(
                          darkMode: theme.brightness == Brightness.dark,
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      transform: Matrix4.translationValues(
                        0,
                        translateAnimation.value,
                        0,
                      ),
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<LoginUICubit, LoginUIState>(
                        builder: (context, state) {
                          final loginModel = state.userIsDoctor
                              ? StreamableTextModel(" Doctor !")
                              : StreamableTextModel(" Patient !");
                          final buttonModel = state.userIsDoctor
                              ? StreamableTextModel("Patient ?")
                              : StreamableTextModel("Doctor ?");
                          final buttonIcon = state.userIsDoctor
                              ? FlutterRemix.empathize_line
                              : FlutterRemix.stethoscope_line;
                          return LoginUserSwitcher(
                            loginAsModel: loginModel,
                            buttonModel: buttonModel,
                            iconData: buttonIcon,
                          );
                        },
                      ),
                      LoginCard(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        snackBar: snackBar,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
