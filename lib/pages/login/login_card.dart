import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../bloc/loginBloc/login_ui_cubit.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.snackBar,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final SnackBar snackBar;

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> _handleLogin(BuildContext context) async {
    {
      final cubit = context.read<LoginUICubit>();
      cubit.setEmail(widget._emailController.text);
      cubit.setPassword(widget._passwordController.text);
      if (cubit.state.userIsDoctor) {
        return await cubit.loginDoctor();
      } else {
        return await cubit.loginPatient();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      height: 300,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      width: max(0, MediaQuery.of(context).size.width - 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Text(
                  "Almost there !",
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: widget._emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: theme.textTheme.bodyText1,
                      onEditingComplete: () {
                        BlocProvider.of<LoginUICubit>(context)
                            .setEmail(widget._emailController.text);
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
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: widget._passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: theme.textTheme.bodyText1,
                        onEditingComplete: () {
                          context
                              .read<LoginUICubit>()
                              .setPassword(widget._passwordController.text);
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "register");
                  },
                  child: Text(
                    "New here? Register your account",
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.subtitle2?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? Colors.lightBlue.shade200
                          : Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    _handleLogin(context).then((value) {
                      if (value) {
                        Navigator.pushReplacementNamed(context, "home");
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(widget.snackBar);
                      }
                    });
                  },
                  child: const Icon(
                    FlutterRemix.arrow_right_s_line,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
