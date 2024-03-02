//geo_math.dart

/*
  // in develop
  //checks the perpendicular from a point to a line
  static bool isNearTheEdge({
    required LatLng point, required LatLng startOfSegment, required LatLng endOfSegment, required double desiredPerpendicularLength}) {

    final double perpendicularDistance = desiredPerpendicularLength;

    // Geographic coordinates of vector
    final double phiA = _toRadians(startOfSegment.latitude);
    final double thetaA = _toRadians(startOfSegment.longitude);
    final double phiB = _toRadians(endOfSegment.latitude);
    final double thetaB = _toRadians(endOfSegment.longitude);

    //transforming a vector into Cartesian coordinate system
    final double xBA = (math.sin(phiA) * math.cos(thetaA)) - (math.sin(phiB) * math.cos(thetaB));
    final double yBA = (math.sin(phiA) * math.sin(thetaA)) - (math.sin(phiB) * math.sin(thetaB));
    final double zBA = math.cos(phiA) - math.cos(phiB);

    //Rotating vector BA 90 degrees counterclockwise to obtain vector AC
    double xAC = -yBA;
    double yAC = xBA;
    double zAC = zBA;

    //Rotating vector BA 90 degrees clockwise to obtain vector BD
    double xBD = yBA;
    double yBD = -xBA;
    double zBD = zBA;

    final double lengthAC = math.sqrt((xAC * xAC) + (yAC * yAC) + (zAC * zAC));
    final double lengthBD = math.sqrt((xBD * xBD) + (yBD * yBD) + (zBD * zBD));

    final double scaleAC = perpendicularDistance / lengthAC;
    final double scaleBD = perpendicularDistance / lengthBD;

    xAC = xAC * scaleAC;
    yAC = yAC * scaleAC;
    zAC = zAC * scaleAC;

    xBD = xBD * scaleBD;
    yBD = yBD * scaleBD;
    zBD = zBD * scaleBD;

    //The determination of the geographic coordinates of points C and D
    final LatLng C = LatLng(_toDegrees(math.asin(zAC)), _toDegrees(math.atan2(yAC, xAC)));
    final LatLng D = LatLng(_toDegrees(math.asin(zBD)), _toDegrees(math.atan2(yBD, xBD)));

    final bool isLatitudeBetween = (C.latitude <= point.latitude && point.latitude <= D.latitude) ||
        (D.latitude <= point.latitude && point.latitude <= C.latitude);

    final bool isLongitudeBetween = (C.longitude <= point.longitude && point.longitude <= D.longitude) ||
        (D.longitude <= point.longitude && point.longitude <= C.longitude);

    return isLatitudeBetween && isLongitudeBetween;
  }
  */

//part of isPointOnPolyline
/*
    // polyline edges check (in develop)
    for (int i = 0; i < (polyline.length - 1); i++){
      LatLng startOfSegment = polyline[i];
      LatLng endOfSegment = polyline[i+1];

      if (GeoMathUtils.isNearTheEdge(
          point: point,
          startOfSegment: startOfSegment,
          endOfSegment: endOfSegment,
          desiredPerpendicularLength: desiredRadius)){
        return true;
      }
    }
    */

///////////////////////////////////////////////////////

//unit_test.dart

/*
    // in develop
    group('Testing isNearTheEdge()', () {
      test('Test 2.0: testing isNearTheEdge()', () {
        const LatLng point = LatLng(0.5, 0);
        const LatLng startOfSegment = LatLng(0, 0);
        const LatLng endOfSegment = LatLng(1, 0);
        const double perpendicularLength = 1000000;

        final bool result = GeoMathUtils.isNearTheEdge(
            point: point,
            startOfSegment: startOfSegment,
            endOfSegment: endOfSegment,
            desiredPerpendicularLength: perpendicularLength);

        expect(result, true);
      });
    });
    */

/*
    not used
    group('Testing convertHashToBase32()', () {
      test('Test 0.0: testing getGeoHashFromLocation()', () {
        const Map<int, String> dictionary = {0:'0', 1:'1', 2:'2', 3:'3', 4:'4', 5:'5', 6:'6', 7:'7', 8:'8', 9:'9', 10:'b',
          11:'c', 12:'d', 13:'e', 14:'f', 15:'g', 16:'h', 17:'j', 18:'k', 19:'m', 20:'n', 21:'p', 22:'q', 23:'r', 24:'s',
          25:'t', 26:'u', 27:'v', 28:'w', 29:'x', 30:'y', 31:'z'};

        for (int i = 0; i<32; i++){
          final String result = GeoHashUtils.convertHashToBase32(val: i);
          expect(result, dictionary[i]);
        }

      });

      test('Test 0.1: testing getGeoHashFromLocation()', () {

        final String result = GeoHashUtils.convertHashToBase32(val: 32);
        expect(result, '&');
      });

      test('Test 0.2: testing getGeoHashFromLocation()', () {
        final String result = GeoHashUtils.convertHashToBase32(val: -1);
        expect(result, '&');
      });
    });
    */

/*
    not used
    group('Testing convertHashFromBase32()', () {});
     */

////////////////////////////////////////////////////

//geo_hash_utils.dart

/*
  not used

  static String convertHashToBase32({required int val}) {
    const Map<int, String> dictionary = {
      0: '0', 1: '1', 2: '2', 3: '3', 4: '4', 5: '5', 6: '6', 7: '7', 8: '8', 9: '9', 10: 'b', 11: 'c', 12: 'd',
      13: 'e', 14: 'f', 15: 'g', 16: 'h', 17: 'j', 18: 'k', 19: 'm', 20: 'n', 21: 'p', 22: 'q', 23: 'r', 24: 's',
      25: 't', 26: 'u', 27: 'v', 28: 'w', 29: 'x', 30: 'y', 31: 'z'
    };

    // Ensure the key exists in the dictionary
    if (dictionary.containsKey(val)) {
      return dictionary[val]!; // Non-null assertion operator (!)
    } else {
      return '&';
    }
  }
   */

//part of getGeoHashFromLocation
/*
    wrong, try again

    //static String geoHashFromLocation({required LatLng location, int precision = 11})

    if (precision <= 0) {
      throw ArgumentError('precision must be greater than 0');
    } else if (precision > 22) {
      throw ArgumentError('precision cannot be greater than 22');
    }
    Map<String, double> latitudeRange = {'min': -90.0, 'max': 90.0};
    Map<String, double> longitudeRange = {'min': -180.0, 'max': 180.0};
    String hash = '';
    int hashVal = 0;
    int bits = 0;
    bool even = true;
    while (hash.length < precision) {
      double val = even ? location.longitude : location.latitude;
      Map<String, double> range = even ? longitudeRange : latitudeRange;
      double mid = (range['min']! + range['max']!) / 2;

      if (val > mid) {
        hashVal = (hashVal << 1) + 1;
        range['min'] = mid;
      } else {
        hashVal = (hashVal << 1) + 0;
        range['max'] = mid;
      }
      even = !even;
      if (bits < 4) {
        bits++;
      } else {
        bits = 0;
        hash += convertHashToBase32(val: hashVal);
        hashVal = 0;
      }
    }
     */

/*
  not used

  static int convertHashFromBase32({required String val}) {
    const Map<String, int> dictionary = {
      '0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, 'b': 10, 'c': 11, 'd': 12,
      'e': 13, 'f': 14, 'g': 15, 'h': 16, 'j': 17, 'k': 18, 'm': 19, 'n': 20, 'p': 21, 'q': 22, 'r': 23, 's': 24,
      't': 25, 'u': 26, 'v': 27, 'w': 28, 'x': 29, 'y': 30, 'z': 31
    };

    // Ensure the key exists in the dictionary
    if (dictionary.containsKey(val)) {
      return dictionary[val]!; // Non-null assertion operator (!)
    } else {
      return -1;
    }
  }

  static double _decode ({required Map<String, double> coordinatesRange, required String binaryString}){
    for (int i = 0; i < binaryString.length; i++){
      double mid  = (coordinatesRange['min']! + coordinatesRange['max']!) / 2;

      if (binaryString[i] == '1'){
        coordinatesRange['min'] = mid;
      } else {
        coordinatesRange['max'] = mid;
      }
    }

    return (coordinatesRange['min']! + coordinatesRange['max']!) / 2;
}
   */

//part of getLocationFromGeoHash
/*
    wrong, try again

    List<int> decimalGeohash = [];
    for(int i = 0; i < geohash.length; i++){
      decimalGeohash.add(convertHashFromBase32(val: geohash[i]));
    }

    List<String> binaryGeohash = [];
    for (int digit in decimalGeohash){
      binaryGeohash.add(digit.toRadixString(2));
    }

    final String binaryString = binaryGeohash.join();
    String binaryLatitude = '';
    String binaryLongitude = '';

    for (int i = 0; i < binaryString.length; i++){
      if(int.parse(binaryString[i]).isEven){
        binaryLatitude += binaryString[i];
      } else {
        binaryLongitude += binaryString[i];
      }
    }

    Map<String, double> latitudeRange = {'min': -90.0, 'max': 90.0};
    Map<String, double> longitudeRange = {'min': -180.0, 'max': 180.0};
    double latitude = _decode(coordinatesRange: latitudeRange, binaryString: binaryLatitude);
    double longitude = _decode(coordinatesRange: longitudeRange, binaryString: binaryLongitude);
     */

/*
  // Create dictionary with keys as geo hashes that will contain their corresponding path segments
  static Map<String, List<LatLng>> _parsWayByGeoHashes({required List<LatLng> points, int precision = 5}){

    final Map<String, List<LatLng>> routeGeoHashes = {};
    for (LatLng point in points){
      String geoHash = getGeoHashFromLocation(location: point, precision: precision);
      routeGeoHashes[geoHash] = (routeGeoHashes[geoHash] ?? [])..add(point);
      // ?? gets list of points for current geo hash, or creates it, if it doesn't exist
    }
    return routeGeoHashes;
  }
   */

//part of checkPointSideOnWay
/*
    potentially more effective algorithm:

    final Map<String, List<LatLng>> sidePointsGeoHashes = parsWayByGeoHashes(points: sidePoints, precision: checkingPrecision);
    final Map<String, List<LatLng>> wayPointsGeoHashes = parsWayByGeoHashes(points: wayPoints, precision: checkingPrecision);

    final Set<String> sidePointsKeys = sidePointsGeoHashes.keys.toSet();
    final Set<String> wayPointsKeys = wayPointsGeoHashes.keys.toSet();

    final List<String> onWay = [];
    final List<String> notOnWay = [];
    for (String sidePointKey in sidePointsKeys){
      (wayPointsKeys.contains(sidePointKey)) ? onWay.add(sidePointKey) : notOnWay.add(sidePointKey);
    }

    return [];
    */