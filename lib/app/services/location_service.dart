import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newsline/app/models/location.dart';
import 'package:newsline/app/services/internet-service.dart';
import 'package:rxdart/subjects.dart';

/// Utility to keep track of the availability of users location,
/// so that the news articles can be fetched accordingly.
enum LocationState { Unavailable, Finding, Available }

/// The `LocationService` class extends the [ChangeNotifier] so that
/// all listeners can be notified when there is any update or change
/// in user location. This contains all the methods to detect, update
/// and store user location.
class LocationService extends ChangeNotifier {
  /// The current location of the user. By defaut it is null.
  /// It is set once the app is loaded.
  Location _userLocation;

  Location get userLocation {
    return _userLocation;
  }

  /// A publish subject of type location state to listen
  /// to changes in the location state.
  PublishSubject<LocationState> _locationStateSubject = PublishSubject();

  /// Getter for location state
  PublishSubject<LocationState> get locationStateSubject {
    return _locationStateSubject;
  }

  /// An instance of the Geolocator package
  Geolocator _geolocator = Geolocator();

  /// Get the user's current location, and if that isn't available
  /// then get the last known location.
  Future getUserLocation() async {
    _locationStateSubject.add(LocationState.Finding);

    try {
      Position position;

      position = await _geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      if (position == null)
        position = await _geolocator.getLastKnownPosition(
            desiredAccuracy: LocationAccuracy.best);

      // Try to geocode only if the Position instance is not null.
      if (position != null) {
        await geocodeReceivedLocation(position);
      } else {
        updateLocationState();
      }
    } catch (e) {
      print(e);
    }
  }

  /// Geocode the user's current/stored coordinates and get the relevant details.
  Future geocodeReceivedLocation(Position position) async {
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark userPlacemark = placemarks[0];

    if (userPlacemark != null) {
      updateUserLocation(position, userPlacemark);
    } else {
      updateLocationState();
    }
  }

  /// Create an instance of the custom [Location] model and assign it
  /// to [userLocation].
  void updateUserLocation(Position position, Placemark userPlacemark) {
    Location location = Location(
        latitude: position.latitude,
        longitude: position.longitude,
        country: userPlacemark.country,
        isoCountryCode: userPlacemark.isoCountryCode.toLowerCase(),
        administrativeArea: userPlacemark.administrativeArea);

    if (location != null) {
      _userLocation = location;
      notifyListeners();
      updateLocationState();
    } else {
      updateLocationState();
    }
  }

  /// Update the location state based on availability
  /// of user's location.
  void updateLocationState() {
    if (_userLocation == null) {
      _locationStateSubject.add(LocationState.Unavailable);
    } else {
      _locationStateSubject.add(LocationState.Available);
    }
  }
}
