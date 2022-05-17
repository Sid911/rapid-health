import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/global/logo_mini.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final totalTime = 700;
  late int index;
  @override
  void initState() {
    super.initState();

    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: LogoMini(
                    darkMode: theme.brightness == Brightness.dark,
                    height: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Navigation",
                    style: theme.textTheme.headline3,
                  ),
                ),
              ],
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
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "about");
                  },
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
                    Navigator.popAndPushNamed(context, "projects");
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
                    Navigator.popAndPushNamed(context, "about");
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
            TextButton.icon(
                label: const Text("Settings"),
                onPressed: () {},
                icon: const Icon(FlutterRemix.settings_6_fill))
          ],
        ),
      ),
    );
  }
}
