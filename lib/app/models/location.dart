import 'package:flutter/foundation.dart';

/// `Location` class will act as a represntative model class,
/// for storing onlt the information relevant to the app.
/// `latitude` and `longitude` store the co-ordinates of the user's location
/// `country` and`isoCountryCode` are the user's country and the two character code respectively.
/// `administrativeArea` is to make the experience more personal for the user
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