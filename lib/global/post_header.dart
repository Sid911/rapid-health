import 'package:flutter/material.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

import 'chips.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    Key? key,
    required this.postData,
    this.distance,
  }) : super(key: key);

  final PostPreview postData;
  final double? distance;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool darkMode = theme.brightness == Brightness.dark;
    return Hero(
      tag: postData.postDataHash,
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
                          postData.postDate
                              .toIso8601String()
                              .substring(0, 10)
                              .replaceAll("-", "/"),
                          style:
                              theme.textTheme.subtitle2?.copyWith(fontSize: 10),
                        ),
                      ),
                      CustomChip(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          postData.postCategory.getString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                      if (distance != null)
                        CustomChip(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            "$distance Km",
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Text(
                  postData.title,
                  style: theme.textTheme.bodyText1,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  "'${postData.subtitle}'",
                  style: theme.textTheme.subtitle2,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
