import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
