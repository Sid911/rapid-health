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
  @HiveField(9)
  final String postHash;

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
    required this.postHash,
  });

  PostData copyWith({
    String? title,
    String? description,
    String? subtitle,
    DateTime? postDate,
    DateTime? expireDate,
    String? authorUID,
    DoctorCategory? postCategory,
    List<double>? coordinates,
    String? address,
    String? postHash,
  }) {
    return PostData(
      title: title ?? this.title,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      postDate: postDate ?? this.postDate,
      expireDate: expireDate ?? this.expireDate,
      authorUID: authorUID ?? this.authorUID,
      postCategory: postCategory ?? this.postCategory,
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
      postHash: postHash ?? this.postHash,
    );
  }
}

@HiveType(typeId: 9, adapterName: "PostPreviewAdapter")
class PostPreview {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  @HiveField(2)
  final DoctorCategory postCategory;
  // @HiveField(3)
  // final List<double> coordinates;
  @HiveField(4)
  final String postDataHash;
  @HiveField(3)
  final DateTime postDate;

  PostPreview({
    required this.title,
    required this.subtitle,
    required this.postCategory,
    required this.postDate,
    required this.postDataHash,
  });

  PostPreview.fromPostData(PostData postData)
      : title = postData.title,
        subtitle = postData.subtitle,
        postCategory = postData.postCategory,
        postDate = postData.postDate,
        postDataHash = postData.postHash;
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
