import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class PlaceMark {
  final String name; // GoogleMapで表示される名前
  final String address; // GoogleMapで表示される住所
  final LatLng latLng; // GoogleMapで表示される緯度経度
  const PlaceMark(
      {required this.name, required this.address, required this.latLng});
}
