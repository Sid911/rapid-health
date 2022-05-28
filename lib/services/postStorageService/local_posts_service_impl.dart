import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

class LocalPostsService extends PostsServiceInterface {
  @override
  Future<void> addPostData(PostData data) {
    // TODO: implement addPostData
    throw UnimplementedError();
  }

  @override
  Future<void> addPosts(Posts data) {
    // TODO: implement addPosts
    throw UnimplementedError();
  }

  @override
  Future<void> addReview(String postID) {
    // TODO: implement addReview
    throw UnimplementedError();
  }

  @override
  Future<List<PostData>> getAllPostData() {
    // TODO: implement getAllPostData
    throw UnimplementedError();
  }

  @override
  Future<PostData> getPostData(String postUID) {
    // TODO: implement getPostData
    throw UnimplementedError();
  }

  @override
  Future<Posts> getPosts(String authorUID) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Reviews> getReviewsForPost(String postUID) {
    // TODO: implement getReviewsForPost
    throw UnimplementedError();
  }
}
