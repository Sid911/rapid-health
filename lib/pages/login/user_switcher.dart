import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class LoginUserSwitcher extends StatelessWidget {
  const LoginUserSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typography = theme.brightness == Brightness.dark
        ? theme.typography.white
        : theme.typography.black;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(text: "Login as ", children: [
              TextSpan(
                text: " Patient !",
                style: TextStyle(
                  backgroundColor: theme.textTheme.bodyText1?.color,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ]),
            style: theme.textTheme.bodyText1,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  FlutterRemix.stethoscope_line,
                  color: typography.bodyText1?.color,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Doctor ?",
                    style: typography.bodyText1,
                  ),
                ),
                Icon(
                  FlutterRemix.arrow_right_s_line,
                  color: typography.bodyText1?.color,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
