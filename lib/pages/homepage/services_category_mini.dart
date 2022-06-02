import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ServicesCategoryMini extends StatelessWidget {
  const ServicesCategoryMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: const Text("Dn"),
                  backgroundColor: theme.primaryColor,
                ),
                const Text("Dentist")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: darkMode
                  ? Colors.blueGrey.shade600
                  : Colors.blueGrey.shade200,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Center(
                    child: Icon(
                      darkMode
                          ? FlutterRemix.heart_pulse_line
                          : FlutterRemix.heart_pulse_fill,
                      color: theme.textTheme.bodyText1?.color,
                      size: 30,
                    ),
                  ),
                ),
                const Text("Emergency")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: const Text("Gy"),
                  backgroundColor: theme.primaryColor,
                ),
                const Text("Gynecologist")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: const Text("Ph"),
                  backgroundColor: theme.primaryColor,
                ),
                const Text("Physician")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: const Text("Or"),
                  backgroundColor: theme.primaryColor,
                ),
                const Text("Orthopaedic")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
