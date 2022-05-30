import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';
import 'package:rapid_health/utility/local_server.dart';

class LocalPostsService extends PostsServiceInterface {
  @override
  Future<void> addPostData(PostData data, String authorID) async {
    await LocalServer.addPost(authorID, data);
  }

  @override
  Future<void> addReview(String postID) {
    // TODO: implement addReview
    throw UnimplementedError();
  }

  @override
  Future<List<PostData>> getAllPostData() async {
    return LocalServer.postDataBox.values.toList(growable: false);
  }

  @override
  Future<PostData> getPostData(String postUID) {
    // TODO: implement getPostData
    throw UnimplementedError();
  }

  @override
  Future<Posts> getPosts(String authorUID) async {
    return LocalServer.postsBox.get(authorUID)!;
  }

  @override
  Future<Reviews> getReviewsForPost(String postUID) {
    // TODO: implement getReviewsForPost
    throw UnimplementedError();
  }
}
