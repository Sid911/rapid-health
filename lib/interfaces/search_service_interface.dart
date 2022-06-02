import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/coordinate.dart';

abstract class SearchServiceInterface {
  Future<List<PostData>> search(
    String term,
    Coordinate location, [
    bool ascending = true,
    int totalResults = 5,
  ]);
}
