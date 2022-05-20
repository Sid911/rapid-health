class Coordinate {
  double latitude = 0;
  double longitude = 0;

  Coordinate(this.latitude, this.longitude);

  Coordinate.fromList(List<double> list) {
    latitude = list[0];
    longitude = list[1];
  }
}
