import 'package:geocoding/geocoding.dart';

class PlaceAndLocation {
  Place? place;
  Location? location;
  PlaceAndLocation({this.place, this.location});
}

class Place {
  String? city;
  String? zipCode;
  String? fullAddress;

  Place({this.city, this.zipCode, this.fullAddress});

  @override
  String toString() {
    return 'Place(fullAddress: city: $city, zipCode: $zipCode)';
  }
}
