import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/utility/streamable_text_model.dart';

import '../../bloc/loginBloc/login_ui_cubit.dart';

class LoginUserSwitcher extends StatelessWidget {
  const LoginUserSwitcher({
    Key? key,
    required this.loginAsModel,
    required this.buttonModel,
    required this.iconData,
  }) : super(key: key);
  final StreamableTextModel loginAsModel;
  final StreamableTextModel buttonModel;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typography = theme.brightness == Brightness.dark
        ? theme.typography.white
        : theme.typography.black;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: max(0, size.height - 550)),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<String>(
              stream: loginAsModel.toStream(
                  initialDelay: const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Text.rich(
                  TextSpan(text: "Login as ", children: [
                    if (snapshot.hasData)
                      TextSpan(
                        text: snapshot.data,
                        style: TextStyle(
                          backgroundColor: theme.textTheme.bodyText1?.color,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                  ]),
                  style: theme.textTheme.bodyText1,
                );
              }),
          ElevatedButton(
            onPressed: () {
              context.read<LoginUICubit>().toggleUserIsDoctor();
            },
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: typography.bodyText1?.color,
                ),
                StreamBuilder<String>(
                  stream: buttonModel.toStream(
                      initialDelay: const Duration(seconds: 3)),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        snapshot.hasData ? snapshot.data! : "",
                        style: typography.bodyText1,
                      ),
                    );
                  },
                ),
                Icon(
                  FlutterRemix.arrow_right_s_line,
                  color: typography.bodyText1?.color,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
