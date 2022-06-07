import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/coordinate.dart';
import 'package:rapid_health/utility/doctor_categories.dart';
import 'package:rapid_health/utility/user.dart';

abstract class SearchServiceInterface {
  // Searches Posts for the term leaving blank returns any 5 results
  Future<List<PostData>> searchPosts(
    String term,
    Coordinate location,
    DoctorCategory? category, [
    bool ascending = true,
    int totalResults = 5,
  ]);

  Future<List<User>> searchPeople(
    String term, [
    int totalResults = 5,
    bool shuffle = false,
  ]);
}
