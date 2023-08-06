library geocoding_client_interface;

import 'dart:math';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:logger/logger.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'not_found_geocoding_api_place.dart';
import 'place_mark.dart';
import 'package:geocoding/geocoding.dart';

final logger = Logger(printer: PrettyPrinter());

abstract class GeocodingClient extends PlatformInterface {
  GeocodingClient() : super(token: _token);

  static final Object _token = Object();

  static GeocodingClient _instance = GeocodingClientDefault();

  static GeocodingClient get instance => _instance;

  static set instance(GeocodingClient instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<PlaceMark>> getGeocode(String searchText);

  Future<PlaceMark> getPlaceMark(LatLng latLng);
}

class GeocodingClientDefault extends GeocodingClient {
  GeocodingClientDefault();

  static const int searchResultLimit = 5;

  @override
  Future<List<PlaceMark>> getGeocode(String searchText) async {
    List<Location> locations =
        await locationFromAddress(searchText, localeIdentifier: 'ja_JP');
    locations = locations.sublist(0, min(searchResultLimit, locations.length));
    if (locations.isEmpty) {
      throw NotFoundGeocodingApiPlace();
    }
    List<PlaceMark> places = [];
    for (var location in locations) {
      logger.d(
          'timestamp: ${location.timestamp}, ${location.latitude}, ${location.longitude}');
      var latLng = LatLng(location.latitude, location.longitude);
      var reverseGeocodePlaceMark = await getPlaceMark(latLng);
      places.add(PlaceMark(
          name: searchText,
          address: reverseGeocodePlaceMark.address,
          latLng: latLng));
    }
    return places;
  }

  @override
  Future<PlaceMark> getPlaceMark(LatLng latLng) async {
    var placeMarks = (await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'ja_JP'));
    if (placeMarks.isEmpty) {
      throw NotFoundGeocodingApiPlace();
    }
    placeMarks.map((place) {
      logger.d("place: $place");
    }).toList();
    return PlaceMark(
        name: placeMarks[0].locality ?? "名前を変更してね",
        address: placeMarks[0].street ?? "",
        latLng: latLng);
  }
}
