import 'package:flutter/material.dart';

class NotFoundWrapper extends StatelessWidget {
  const NotFoundWrapper({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 300,
      child: Center(
        child: Text(
          text,
          style:
              theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
