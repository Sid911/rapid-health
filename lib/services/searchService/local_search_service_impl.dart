import 'package:rapid_health/interfaces/search_service_interface.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/coordinate.dart';

import '../../utility/local_server.dart';

class LocalSearchService extends SearchServiceInterface {
  @override
  Future<List<PostData>> search(
    String term,
    Coordinate location, [
    bool ascending = true,
    int totalResults = 5,
  ]) async {
    final List<PostData> resultList = List.empty(growable: true);

    final values = LocalServer.postDataBox.values;
    for (final val in values) {
      resultList.add(val);
    }
    return resultList;
  }
}
