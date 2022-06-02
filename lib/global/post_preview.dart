import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/pages/post_view/post_view.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

class PostPreviewWidget extends StatelessWidget {
  const PostPreviewWidget({Key? key, required this.preview})
      : super(
          key: key,
        );
  final PostPreview preview;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostViewPage(
              postUID: preview.postDataHash,
              previewData: preview,
            ),
          ),
        );
      },
      child: Hero(
        tag: preview.postDataHash,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: (darkMode ? Colors.lightBlueAccent : Colors.black)
                      .withOpacity(darkMode ? 0.2 : 0.1),
                  offset: const Offset(0, 15),
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomChip(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            preview.postDate
                                .toIso8601String()
                                .substring(0, 10)
                                .replaceAll("-", "/"),
                            style: theme.textTheme.subtitle2
                                ?.copyWith(fontSize: 10),
                          ),
                        ),
                        CustomChip(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            preview.postCategory.getString(),
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const Icon(FlutterRemix.arrow_right_s_line),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Text(
                    preview.title,
                    style: theme.textTheme.bodyText1,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    "'${preview.subtitle}'",
                    style: theme.textTheme.subtitle2,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
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
