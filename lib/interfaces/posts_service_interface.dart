import 'package:rapid_health/services/postStorageService/post_data.dart';

import '../services/reviewStorageService/review_data.dart';

abstract class PostsServiceInterface {
  Future<void> addPostData(PostData data, String authorID);
  Future<void> addReview(String postID, ReviewData data);

  Future<PostData?> getPostData(String postUID);
  Future<Posts?> getPosts(String authorUID);
  Future<List<PostData>> getAllPostData();
  Future<Reviews?> getReviewsForPost(String postUID);
}
