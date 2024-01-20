import 'dart:math' as math;

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

//ignore_for_file: avoid_classes_with_only_static_members
class GeoMath {
  //generated by copilot(gpt-4 chat)
  //TODO: rewrite, check add tests
  static double getDistance({required LatLng point1, required LatLng point2}) {
    final double lat1 = point1.latitude;
    final double lon1 = point1.longitude;

    final double lat2 = point2.latitude;
    final double lon2 = point2.longitude;

    const double earthRadius = 6371000.0;
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double a = math.pow(math.sin(dLat / 2), 2) +
        math.pow(math.sin(dLon / 2), 2) *
            math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2));
    final double c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }

  //generated by copilot(gpt-4 chat)
  //TODO: rewrite, check add tests
  bool isPointOnPolyline(
      {required LatLng point, required List<LatLng> polyline, double? radius}) {
    //TODO:
    return false;
  }

  static double getNextRoutePoint(
      {required LatLng currentLocation, required List<LatLng> route}) {
    //TODO:
    return 0;
  }

  static double getDistanceToNextPoint(
      {required LatLng currentLocation, required List<LatLng> route}) {
    //TODO:
    return 0;
  }

  static double _toRadians(double deg) {
    return deg * (math.pi / 180);
  }
}
