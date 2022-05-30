import 'package:flutter/material.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';

class PostPreviewWidget extends StatelessWidget {
  const PostPreviewWidget({Key? key, required this.preview}) : super(key: key);
  final PostPreview preview;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100,
      color: theme.primaryColor,
    );
  }
}
