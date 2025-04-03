
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GetLocationUseCase  {
  Future<LatLng> call() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception("Location service is disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location Permission denied permanently.");
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      throw Exception("Location permission is required.");
    }
    }
    Position position = await Geolocator.getCurrentPosition(
    locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ),
    );
    return LatLng(position.latitude, position.longitude);
  }
}