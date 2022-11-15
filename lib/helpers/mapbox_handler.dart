import 'package:mapbox_gl/mapbox_gl.dart';

import '../requests/mapbox_rev_geocoding.dart';

// ----------------------------- Mapbox Reverse Geocoding -----------------------------

Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  Map<String, dynamic> response =
      await getReverseGeocodingGivenLatLngUsingMapbox(latLng);
  Map feature = response['features'][0];
  Map revGeocode = {
    'name': feature['text'],
    'address': feature['place_name'].split('${feature['text']}, ')[1],
    'place': feature['place_name'],
    'location': latLng
  };
  print(revGeocode);
  return revGeocode;
}
