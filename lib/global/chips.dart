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
