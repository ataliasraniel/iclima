import 'package:geolocator/geolocator.dart';
import 'package:iclima/screens/home_screen.dart';

class Location {
  double latitude;
  double longitude;

  HomeScreen _homeScreen = HomeScreen();

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Localização negada para sempre');
      }
      if (permission == LocationPermission.denied) {
        return Future.error('Localização negada');
      }
    }
    var loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = loc.latitude;
    longitude = loc.longitude;
    return loc;
  }
}
