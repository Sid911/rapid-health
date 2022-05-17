import 'package:flutter/material.dart';

class LogoMini extends StatelessWidget {
  const LogoMini({
    Key? key,
    required this.darkMode,
    this.padding,
    this.height,
  }) : super(key: key);

  final bool darkMode;
  final EdgeInsets? padding;
  final double? height;
  EdgeInsets get edgeInsetspadding => padding ?? const EdgeInsets.all(5);

  @override
  Widget build(BuildContext context) {
    final logoAsset =
        darkMode ? "assets/1x/logoLight.png" : "assets/1x/logoDark.png";
    return Hero(
      tag: "logoMini",
      child: Container(
        height: height,
        padding: edgeInsetspadding,
        child: Image.asset(logoAsset),
      ),
    );
  }
}
