import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/global/chips.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

import 'doctor_posts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userData, required this.isDoctor})
      : super(key: key);
  final UserData userData;
  final bool isDoctor;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late UserData userData;
  late bool isDoctor;
  String initials = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userData = widget.userData;
    isDoctor = widget.isDoctor;
    for (String s in userData.name.split(" ")) {
      initials += s[0];
    }
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        onTap: () {},
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
                            text: userData.name,
                            children: [
                              TextSpan(
                                text: '\n' + userData.email,
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: UserChip(name: "doctor"),
              ),
              isDoctor
                  ? ProfileDoctorPosts(userData: userData as DoctorData)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
