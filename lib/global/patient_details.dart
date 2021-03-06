import 'package:flutter/material.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({
    Key? key,
    required this.data,
    this.onlyDetails = false,
  }) : super(key: key);
  final PatientData data;
  final bool onlyDetails;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    String initials = "";
    for (String s in data.name.split(" ").sublist(0, 2)) {
      initials += s[0];
    }
    final avatarColor = theme.scaffoldBackgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!onlyDetails)
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
                      data.name,
                      style: theme.textTheme.bodyText1,
                    ),
                    Text(
                      data.email,
                      style: theme.textTheme.subtitle2,
                    ),
                    Text(
                      "Age : ${data.age}",
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (onlyDetails)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: onlyDetails ? theme.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Age. : ${data.age}",
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Phone no. : ${data.phone}",
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Address . : ${data.address}",
                    style: theme.textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
