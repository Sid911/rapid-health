import 'package:rapid_health/interfaces/search_service_interface.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/coordinate.dart';
import 'package:rapid_health/utility/user.dart';

import '../../utility/local_server.dart';

class LocalSearchService extends SearchServiceInterface {
  @override
  Future<List<PostData>> searchPosts(
    String term,
    Coordinate location, [
    bool ascending = true,
    int totalResults = 5,
  ]) async {
    final List<PostData> resultList = List.empty(growable: true);
    final regTerm = RegExp(term, caseSensitive: false);

    final values = LocalServer.postDataBox.values;
    int index = 0;
    for (final val in values) {
      if (index >= totalResults) break;
      if (val.description.contains(regTerm) ||
          val.title.contains(regTerm) ||
          val.subtitle.contains(regTerm)) {
        resultList.add(val);
        index++;
      }
    }
    return resultList;
  }

  @override
  Future<List<User>> searchPeople(
    String term, [
    int totalResults = 4,
    bool shuffle = false,
  ]) async {
    List<User> resultList = List.empty(growable: true);
    final regTerm = RegExp(term, caseSensitive: false);

    final docs = LocalServer.doctorsBox.values
        .where((element) => element.name.contains(regTerm));
    final patients = LocalServer.patientBox.values
        .where((element) => element.name.contains(regTerm));
    for (var element in docs) {
      resultList.add(User(userData: element, isUserDoctor: true));
    }
    for (var element in patients) {
      resultList.add(User(userData: element));
    }
    if (shuffle) resultList.shuffle();
    return resultList;
  }
}
