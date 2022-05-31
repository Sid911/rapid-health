import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({
    Key? key,
    required this.userData,
    required this.isDoctor,
    this.backgroundColor,
  }) : super(key: key);

  final UserData userData;
  final bool isDoctor;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String initials = "";
    for (String s in userData.name.split(" ")) {
      initials += s[0];
    }
    return Container(
      color: backgroundColor ?? theme.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 30,
                  child: Text(
                    initials,
                    style: theme.textTheme.headline4,
                  ),
                  backgroundColor: theme.scaffoldBackgroundColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.name,
                      style: theme.textTheme.bodyText1,
                    ),
                    Text(
                      userData.email,
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FlutterRemix.more_2_line,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
