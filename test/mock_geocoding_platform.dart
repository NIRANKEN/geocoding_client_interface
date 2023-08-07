import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGeocodingPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GeocodingPlatform {
  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    String? localeIdentifier,
  }) async {
    return [
      Location(
        latitude: 12,
        longitude: 23,
        timestamp: DateTime(2023, 7, 19, 17, 30),
      ),
      Location(
        latitude: 23,
        longitude: 34,
        timestamp: DateTime(2023, 7, 19, 17, 31),
      ),
    ];
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) async {
    if (latitude == 12 && longitude == 23) {
      return [
        Placemark(
            name: "dummyName1",
            locality: "dummyLocality1",
            street: "dummyAddress1")
      ];
    } else if (latitude == 23 && longitude == 34) {
      return [
        Placemark(
            name: "dummyName2",
            locality: "dummyLocality2",
            street: "dummyAddress2")
      ];
    }
    return [
      Placemark(
          name: "dummyName", locality: "dummyLocality", street: "dummyAddress")
    ];
  }
}
