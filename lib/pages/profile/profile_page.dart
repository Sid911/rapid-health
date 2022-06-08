import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/global/doctor_details_widget.dart';
import 'package:rapid_health/global/patient_details.dart';
import 'package:rapid_health/pages/profile/patient_reviews.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

import 'doctor_posts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late User user;
  late UserData userData;
  late bool isDoctor;
  String initials = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    user = widget.user;
    userData = user.userData;
    isDoctor = user.isUserDoctor;
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Hero(
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
                                backgroundColor: theme.primaryColor,
                                child: Text(
                                  initials,
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: userData.name,
                                  children: [
                                    TextSpan(
                                      text: '\n${userData.email}',
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
                  ),
                  Flexible(
                    flex: 2,
                    child: isDoctor
                        ? DoctorDetails(
                            data: user.doctorData,
                            onlyDetails: true,
                          )
                        : PatientDetails(
                            data: user.patientData, onlyDetails: true),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: UserChip(name: isDoctor ? "doctor" : "user"),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  thickness: 2,
                  color: theme.primaryColor,
                ),
              ),
              Builder(builder: (context) {
                if (isDoctor) {
                  return ProfileDoctorPosts(userData: user.doctorData);
                }
                return ProfilePatientReviews(user: user);
              })
            ],
          ),
        ),
      ),
    );
  }
}
