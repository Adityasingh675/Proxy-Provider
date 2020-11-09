import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocatorService{

  Future<Position> getCoords () async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<List<Placemark>> getAddress (Position position) async {
    return await GeocodingPlatform.instance.placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: "en");
  }
}
