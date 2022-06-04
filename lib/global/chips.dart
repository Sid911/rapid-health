import 'package:flutter/material.dart';

class UserChip extends StatelessWidget {
  const UserChip({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(
        name,
        style: theme.textTheme.subtitle2,
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({Key? key, required this.child, this.margin})
      : super(key: key);

  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: margin,
      decoration: BoxDecoration(
        color: darkMode ? theme.primaryColorDark : theme.primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
