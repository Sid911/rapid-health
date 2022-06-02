import 'dart:math';

class Coordinate {
  double latitude = 0;
  double longitude = 0;

  Coordinate(this.latitude, this.longitude);

  Coordinate.fromList(List<double> list) {
    latitude = list[0];
    longitude = list[1];
  }

  static double distance(Coordinate a, Coordinate b) {
    return sqrt(
        pow(a.latitude - b.latitude, 2) + pow(a.longitude - b.longitude, 2));
  }
}
