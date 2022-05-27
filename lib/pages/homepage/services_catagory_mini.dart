import 'package:flutter/material.dart';

class ServicesCategoryMini extends StatelessWidget {
  const ServicesCategoryMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      color: theme.primaryColor,
      height: 200,
    );
  }
}
