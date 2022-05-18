import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_health/bloc/loginBloc/login_ui_cubit.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    child: LogoMini(
                      darkMode: theme.brightness == Brightness.dark,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginUserSwitcher(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    height: 300,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    width: max(0, MediaQuery.of(context).size.width - 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: Text(
                                "Almost there !",
                                style: theme.textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: theme.textTheme.bodyText1,
                              onEditingComplete: () {
                                BlocProvider.of<LoginUICubit>(context)
                                    .setEmail(_emailController.text);
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: Text(
                                  "Enter the Email here",
                                  style: theme.textTheme.subtitle2,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                style: theme.textTheme.bodyText1,
                                onEditingComplete: () {
                                  context
                                      .read<LoginUICubit>()
                                      .setPassword(_passwordController.text);
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text(
                                    "Enter the Password here",
                                    style: theme.textTheme.subtitle2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "New here? Register your account",
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.subtitle2?.copyWith(
                                  color: Colors.lightBlue.shade200,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                Colors.blueGrey.shade200,
                              )),
                              onPressed: () async {
                                BlocProvider.of<LoginUICubit>(context)
                                    .setEmail(_emailController.text);
                                context
                                    .read<LoginUICubit>()
                                    .setPassword(_passwordController.text);
                                final result = await context
                                    .read<LoginUICubit>()
                                    .loginPatient();
                                if (result) {
                                  Navigator.pushReplacementNamed(
                                      context, "home");
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: const Text("Login"),
                            )
                          ],
                        )
                      ],
                    ),
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
