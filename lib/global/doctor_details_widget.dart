import 'package:flutter/material.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    Key? key,
    required this.data,
    this.onlyDetails = false,
  }) : super(key: key);
  final DoctorData data;
  final bool onlyDetails;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    String initials = "";
    for (String s in data.name.split(" ").sublist(0, 2)) {
      initials += s[0];
    }
    final avatarColor =
        darkMode ? Colors.blueGrey.shade900 : Colors.blueGrey.shade50;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                        data.website,
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: onlyDetails ? theme.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (onlyDetails)
                  Text(
                    "Website : ${data.website}",
                    style: theme.textTheme.bodyText2,
                  ),
                Text(
                  "Work Address : ${data.workAddress}",
                  style: theme.textTheme.bodyText2,
                ),
                Text(
                  "Work Phone : ${data.workPhone}",
                  style: theme.textTheme.bodyText2,
                ),
                Text(
                  "Major Category : ${data.category.getString()}",
                  style: theme.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
