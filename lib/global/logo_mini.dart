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
  EdgeInsets get edgeInsetsPadding => padding ?? const EdgeInsets.all(5);

  @override
  Widget build(BuildContext context) {
    // final logoAsset =
    //     darkMode ? "assets/1x/logoLight.png" : "assets/1x/logoDark.png";
    const logoAsset = "assets/1x/logoLight.png";
    return Container(
      height: height,
      padding: edgeInsetsPadding,
      child: Image.asset(logoAsset),
    );
  }
}
