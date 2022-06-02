import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rapid_health/global/chips.dart';
import 'package:rapid_health/global/post_preview.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';
import 'package:rapid_health/utility/user.dart';

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({Key? key, required this.reviews}) : super(key: key);
  final Reviews reviews;
  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  late List<ReviewData> _list;
  @override
  void initState() {
    super.initState();
    final len = min(5, widget.reviews.reviews.length);
    _list = widget.reviews.reviews.sublist(0, len);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final UserUID uid = UserUID.fromString(_list[index].authorUID);
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserChip(name: uid.isDoctor ? "Doctor" : "User"),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomChip(child: Text(uid.id))),
                  ],
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    _list[index].title,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _list[index].description,
                  style: theme.textTheme.subtitle2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
