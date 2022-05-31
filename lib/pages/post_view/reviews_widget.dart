import 'package:flutter/material.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({Key? key, required this.reviews}) : super(key: key);
  final Reviews reviews;
  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      color: theme.primaryColor,
    );
  }
}
