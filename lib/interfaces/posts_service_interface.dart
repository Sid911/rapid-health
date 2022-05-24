import 'package:rapid_health/services/postStorageService/post_data.dart';

import '../services/reviewStorageService/review_data.dart';

abstract class PostsServiceInterface {
  PostData getPostData(String postUID);
  Posts getPosts(String authorUID);
  List<PostData> getAllPostData();
  Reviews getReviewsForPost(String postUID);
}
