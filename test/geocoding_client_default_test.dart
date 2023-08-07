import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_client_interface/geocoding_client_interface.dart';
import 'package:geocoding_client_interface/place_mark.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'mock_geocoding_platform.dart';

void main() {
  group('DefaultGeocodingApiClient', () {
    setUp(() {
      GeocodingPlatform.instance = MockGeocodingPlatform();
    });

    test('getGeocode', () async {
      // Setup
      var client = GeocodingClient.instance;

      // Action
      List<PlaceMark> places = await client.getGeocode("dummySearchText");

      // Arrange
      expect(places.length, 2);
      expect(places[0].name, "dummySearchText");
      expect(places[0].address, "dummyAddress1");
      expect(places[0].latLng.latitude, 12);
      expect(places[0].latLng.longitude, 23);
      expect(places[1].name, "dummySearchText");
      expect(places[1].address, "dummyAddress2");
      expect(places[1].latLng.latitude, 23);
      expect(places[1].latLng.longitude, 34);
    });

    test('getPlacemark', () async {
      // Setup
      var client = GeocodingClient.instance;

      // Action
      PlaceMark place = await client.getPlaceMark(const LatLng(12, 23));

      // Arrange
      expect(place.name, "dummyLocality1");
      expect(place.address, "dummyAddress1");
      expect(place.latLng.latitude, 12);
      expect(place.latLng.longitude, 23);
    });
  });
}
