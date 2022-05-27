import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

class LocalPostsService extends PostsServiceInterface {
  @override
  List<PostData> getAllPostData() {
    // TODO: implement getAllPostData
    throw UnimplementedError();
  }

  @override
  PostData getPostData(String postUID) {
    // TODO: implement getPostData
    throw UnimplementedError();
  }

  @override
  Posts getPosts(String authorUID) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Reviews getReviewsForPost(String postUID) {
    // TODO: implement getReviewsForPost
    throw UnimplementedError();
  }
}
