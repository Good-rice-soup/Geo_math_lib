import 'dart:math' as math;

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
/*
https://github.com/juanxme/google_maps_flutter_platform_interface/blob/master/lib/src/types/location.dart

peace of theory about Earth radius
https://en.wikipedia.org/wiki/Great-circle_distance
 */

//ignore_for_file: avoid_classes_with_only_static_members
class GeoMath {
  static const double earthRadius = 6371009.0; //in meters

  static double getDistance({required LatLng point1, required LatLng point2}) {
    const double earthRadius = GeoMath.earthRadius;

    final double lat1 = point1.latitude;
    final double lon1 = point1.longitude;

    final double lat2 = point2.latitude;
    final double lon2 = point2.longitude;

    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double haversinLat = math.pow(math.sin(dLat / 2), 2).toDouble();
    final double haversinLon = math.pow(math.sin(dLon / 2), 2).toDouble();

    final double a = haversinLat + haversinLon * math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2));
    final double c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }

  static bool isPointOnPolyline({required LatLng point, required List<LatLng> polyline, required double desiredRadius}) {

    if (polyline.isEmpty){
      return false;
    }

    if (desiredRadius.isNaN || desiredRadius.isNegative) {
      throw ArgumentError("Variable radius can't be NaN or negative");
    }

    //checking points on a polyline
    double minDistance = double.infinity;
    for (final LatLng polylinePoint in  polyline) {
      final double distance = getDistance(point1: point, point2: polylinePoint);

      if (distance < minDistance){
        minDistance = distance;
      }

      if (minDistance < desiredRadius){
        return true;
      }
    }

    return false;
  }

  static int getNextRoutePoint({required LatLng currentLocation, required List<LatLng> route}) {

    if (route.isEmpty) {
      throw ArgumentError("Variable route can't be empty");
    }

    double minDistance = double.infinity;
    int nextPointIndex = 0;

    for (int i = 0; i < route.length; i++){
      final double distance = getDistance(point1: currentLocation, point2: route[i]);

      if ((distance < minDistance) && (distance > 0)){
        minDistance = distance;
        nextPointIndex = i;
      }
    }
    
    return nextPointIndex;
  }

  static double getDistanceToNextPoint({required LatLng currentLocation, required List<LatLng> route}) {
    final int nextPointIndex = getNextRoutePoint(currentLocation: currentLocation, route: route);
    final LatLng nextPoint = route[nextPointIndex];

    return getDistance(point1: currentLocation, point2: nextPoint);
  }

  static LatLngBounds getRouteCorners({required List<List<LatLng>> listOfRoutes}){

    if (listOfRoutes.isEmpty || listOfRoutes.any((route) => route.isEmpty)) {
      return LatLngBounds(southwest: const LatLng(0.0, 0.0), northeast: const LatLng(0.0, 0.0));
    }

    double minLatitude = double.infinity;
    double maxLatitude = -double.infinity;
    double minLongitude = double.infinity;
    double maxLongitude = -double.infinity;

    for (final List<LatLng> route in listOfRoutes) {
      for (final LatLng coordinate in route) {
        minLatitude = coordinate.latitude < minLatitude ? coordinate.latitude : minLatitude;
        maxLatitude = coordinate.latitude > maxLatitude ? coordinate.latitude : maxLatitude;
        minLongitude = coordinate.longitude < minLongitude ? coordinate.longitude : minLongitude;
        maxLongitude = coordinate.longitude > maxLongitude ? coordinate.longitude : maxLongitude;

      }
    }
    
    final LatLng upperRightCorner = LatLng(maxLatitude, maxLongitude);
    final LatLng lowerLeftCorner = LatLng(minLatitude, minLongitude);

    return LatLngBounds(southwest: lowerLeftCorner, northeast: upperRightCorner);
  }

  static double calculateAzimuth({required LatLng currentPoint,required LatLng nextPoint}) {

    final double lat1 = _toRadians(currentPoint.latitude);
    final double lon1 = _toRadians(currentPoint.longitude);
    final double lat2 = _toRadians(nextPoint.latitude);
    final double lon2 = _toRadians(nextPoint.longitude);
    final double deltaLon = lon2 - lon1;

    // Formula for calculating azimuth
    double azimuth = math.atan2(
        math.sin(deltaLon),
        (math.cos(lat1) * math.tan(lat2)) - (math.sin(lat1) * math.cos(deltaLon))
    );

    azimuth = _toDegrees(azimuth);
    // Normalizing azimuth value to the range [0, 360)
    azimuth = (azimuth + 360) % 360;
    return azimuth;
  }

  static double getDistanceToPoint({required LatLng currentLocation, required List<LatLng> route}) {

    if (route.isEmpty){
      return 0.0;
    }

    double closestDistance = double.infinity;
    for (final LatLng point in route){
      final double distance = getDistance(point1: currentLocation, point2: point);
      if (distance <= closestDistance){
        closestDistance = distance;
      }
    }

    return closestDistance;
  }

  static double _toRadians(double deg) {
    return deg * (math.pi / 180);
  }

  static double _toDegrees(double radians) {
    return (radians * 180) / math.pi;
  }
}



