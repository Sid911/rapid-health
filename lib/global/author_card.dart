import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/utility/user.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({
    Key? key,
    required this.user,
    this.backgroundColor,
  }) : super(key: key);

  final User user;
  final Color? backgroundColor;

  final borderRadii = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    String initials = "";
    for (String s in user.userData.name.split(" ")) {
      initials += s[0];
    }
    final avatarColor = user.isUserDoctor
        ? darkMode
            ? Colors.blueGrey.shade900
            : Colors.blueGrey.shade50
        : theme.scaffoldBackgroundColor;

    final background = (user.isUserDoctor
        ? darkMode
            ? Colors.blueGrey.shade700
            : Colors.blueGrey.shade200
        : theme.primaryColor);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: avatarColor,
                      child: Text(
                        initials,
                        style: theme.textTheme.headline5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.userData.name,
                          style: theme.textTheme.bodyText1,
                        ),
                        Text(
                          user.userData.name,
                          style: theme.textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(FlutterRemix.message_3_line),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                        shape: borderRadii,
                        context: context,
                        builder: (ctx) {
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: avatarColor,
                              borderRadius: borderRadii.borderRadius,
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      FlutterRemix.more_2_line,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
