library geocoding_client_interface;

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'PlaceMark.dart';

abstract class GeocodingClient {
  const GeocodingClient();

  Future<List<PlaceMark>> getGeocode(String searchText);

  Future<PlaceMark> getPlaceMark(LatLng latLng);
}
