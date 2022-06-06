import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/pages/profile/profile_page.dart';

import '../../interfaces/auth_service_interface.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final totalTime = 700;
  late int index;
  late AuthServiceInterface authService;
  @override
  void initState() {
    super.initState();
    authService = context.read<AuthServiceInterface>();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = authService.currentUser!.userData;
    String initials = "";
    for (String s in currentUser.name.split(" ")) {
      initials += s[0];
    }
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        color:
            theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        padding:
            const EdgeInsets.only(left: 30, top: 100, bottom: 20, right: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: "profileAvatar",
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        FlutterRemix.arrow_left_s_line,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            userData: currentUser,
                            isDoctor: authService.currentUser!.isUserDoctor,
                          ),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        child: Text(
                          initials,
                          style: theme.textTheme.headline4,
                        ),
                        backgroundColor: theme.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text.rich(
                        TextSpan(
                          text: currentUser.name,
                          children: [
                            TextSpan(
                              text: '\n' + currentUser.email,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    " - Home",
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight:
                          index == 0 ? FontWeight.bold : FontWeight.w300,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        userData: currentUser,
                        isDoctor: authService.currentUser!.isUserDoctor,
                      ),
                    ),
                  ),
                  child: Text(
                    " - Profile",
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight:
                          index == 2 ? FontWeight.bold : FontWeight.w100,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "bookings");
                  },
                  child: Text(
                    " - Bookings",
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight:
                          index == 1 ? FontWeight.bold : FontWeight.w300,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "chats");
                  },
                  child: Text(
                    " - Chat",
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight:
                          index == 2 ? FontWeight.bold : FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                authService.currentUser!.isUserDoctor
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "newPost");
                          },
                          icon: Icon(
                            FlutterRemix.add_box_line,
                            color: theme.textTheme.subtitle1?.color,
                          ),
                          label: Text(
                            "New Post",
                            style: TextStyle(
                              color: theme.textTheme.subtitle1?.color,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                TextButton.icon(
                  label: Text(
                    "Settings",
                    style: TextStyle(color: theme.textTheme.subtitle1?.color),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    FlutterRemix.settings_6_fill,
                    color: theme.textTheme.subtitle1?.color,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
