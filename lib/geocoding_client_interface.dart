library geocoding_client_interface;

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'place_mark.dart';

abstract class GeocodingClient {
  const GeocodingClient({this.searchResultLimit = 5});
  final int searchResultLimit;

  Future<List<PlaceMark>> getGeocode(String searchText);

  Future<PlaceMark> getPlaceMark(LatLng latLng);
}
