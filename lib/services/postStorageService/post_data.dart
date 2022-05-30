import 'package:hive_flutter/adapters.dart';

import '../../utility/doctor_categories.dart';

part 'post_data.g.dart';

@HiveType(typeId: 8, adapterName: "PostDataAdapter")
class PostData {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String subtitle;
  @HiveField(3)
  final DateTime postDate;
  @HiveField(4)
  final DateTime expireDate;
  @HiveField(5)
  final String authorUID;
  @HiveField(6)
  final DoctorCategory postCategory;
  @HiveField(7)
  final List<double> coordinates;
  @HiveField(8)
  final String address;

  PostData({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.postDate,
    required this.expireDate,
    required this.authorUID,
    required this.postCategory,
    required this.coordinates,
    required this.address,
  });
}

@HiveType(typeId: 9, adapterName: "PostPreviewAdapter")
class PostPreview {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  @HiveField(2)
  final DoctorCategory postCategory;
  @HiveField(3)
  final List<double> coordinates;
  @HiveField(4)
  final String postDataHash;

  PostPreview({
    required this.title,
    required this.subtitle,
    required this.postCategory,
    required this.coordinates,
    required this.postDataHash,
  });

  PostPreview.fromPostData(PostData postData, this.postDataHash)
      : title = postData.title,
        subtitle = postData.subtitle,
        postCategory = postData.postCategory,
        coordinates = postData.coordinates;
}

@HiveType(typeId: 10, adapterName: "PostsAdapter")
class Posts {
  @HiveField(0)
  final String authorUID;
  @HiveField(1)
  final List<PostPreview> previews;

  Posts({
    required this.authorUID,
    required this.previews,
  });
}
