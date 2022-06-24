import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/model/lat_lng.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  factory LocationService() {
    return _singleton;
  }
  LocationService._internal();

  Future<LatLng> getUserLocation() async {
    if (await locationPermissionGranted()) {
      var geoLocation = GeolocatorPlatform.instance;
      var position = await geoLocation.getCurrentPosition();
      return LatLng(lat: position.latitude, lng: position.longitude);
    } else {
      return LatLng(lat: 35.659278, lng: 51.487741);
    }
  }

  Future<bool> locationPermissionGranted() async {
    if (await Permission.location.request().isGranted) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
