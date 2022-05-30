import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ServicesCategoryMini extends StatelessWidget {
  const ServicesCategoryMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  darkMode
                      ? FlutterRemix.mental_health_line
                      : FlutterRemix.mental_health_fill,
                  color: theme.textTheme.bodyText1?.color,
                  size: 30,
                ),
                const Text("Mental Health")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  darkMode
                      ? FlutterRemix.heart_2_line
                      : FlutterRemix.heart_2_fill,
                  color: theme.textTheme.bodyText1?.color,
                  size: 30,
                ),
                const Text("Cardiologist")
              ],
            ),
          )
        ],
      ),
    );
  }
}
