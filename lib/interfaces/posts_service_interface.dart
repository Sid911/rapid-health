import 'package:rapid_health/services/postStorageService/post_data.dart';

import '../services/reviewStorageService/review_data.dart';

abstract class PostsServiceInterface {
  Future<void> addPosts(Posts data);
  Future<void> addPostData(PostData data);
  Future<void> addReview(String postID);

  Future<PostData> getPostData(String postUID);
  Future<Posts> getPosts(String authorUID);
  Future<List<PostData>> getAllPostData();
  Future<Reviews> getReviewsForPost(String postUID);
}
