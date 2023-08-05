class NotFoundGeocodingApiPlace implements Exception {
  String _message = 'geocoding result is not found.';
  NotFoundGeocodingApiPlace() : this._message('geocoding result is not found.');
  NotFoundGeocodingApiPlace._message(this._message);

  @override
  String toString() {
    return _message;
  }
}
