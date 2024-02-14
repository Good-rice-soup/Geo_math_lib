import 'package:latlong2/latlong.dart';

import 'geohash_base.dart';

List<String> getWayGeohashes(
    {required List<LatLng> points, required int precision}) {
  final Set<String> geohashes = {};

  for (int i = 0; i < points.length - 1; i++) {
    final LatLng start = points[i];
    final LatLng end = points[i + 1];

    // Добавляем геохеш начальной точки
    geohashes.add(
        Geohash.encode(start.latitude, start.longitude, codeLength: precision));

    final double distance = const Distance().as(LengthUnit.Meter, start, end);
    /* final double step = Geohash.distance(
        precision); // Расстояние, соответствующее одной плитке геохеша на этой точности
*/
    //TODO
    const double step = 5000;
    for (double d = step; d < distance; d += step) {
      final LatLng intermediate = const Distance()
          .offset(start, d, const Distance().bearing(start, end));
      geohashes.add(Geohash.encode(
          intermediate.latitude, intermediate.longitude,
          codeLength: precision));
    }

    // Добавляем геохеш конечной точки
    geohashes.add(
        Geohash.encode(end.latitude, end.longitude, codeLength: precision));
  }

  return geohashes.toList();
}
