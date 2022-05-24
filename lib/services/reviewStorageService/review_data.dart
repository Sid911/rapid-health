import 'package:hive_flutter/adapters.dart';

part 'review_data.g.dart';

@HiveType(typeId: 14, adapterName: "ReviewDataAdapter")
class ReviewData {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime postDate;
  @HiveField(3)
  final String authorUID;
  ReviewData({
    required this.title,
    required this.description,
    required this.postDate,
    required this.authorUID,
  });
}

@HiveType(typeId: 15, adapterName: "ReviewsAdapter")
class Reviews {
  @HiveField(0)
  final String postUID;
  @HiveField(1)
  final List<ReviewData> reviews;

  Reviews(this.postUID, this.reviews);
}
