import 'package:flutter/foundation.dart';

class Location {

  double latitude;
  double longitude;
  String country;
  String isoCountryCode;
  String administrativeArea;

  Location({
    @required this.latitude,
    @required this.longitude,
    @required this.country,
    @required this.isoCountryCode,
    @required this.administrativeArea
  });
}