import 'dart:convert';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../main.dart';

List<String> getDriverInformation() {
  return sharedPreferences.getStringList("driver-information")!;
}

String getBluebookImage() {
  return sharedPreferences.getString("bluebookImage")!;
}

String getLiscenseImage() {
  return sharedPreferences.getString("liscenseImage")!;
}

bool isFormSubmitted() {
  return sharedPreferences.getBool("form-submitted")!;
}

bool getFirstRun() {
  return sharedPreferences.getBool("first-run")!;
}

bool getCurrentUserMode() {
  if (sharedPreferences.getBool("first-run") == true) {
    return false;
  } else {
    if (sharedPreferences.getBool('user-mode') == null) {
      return false;
    } else {
      return sharedPreferences.getBool('user-mode')!;
    }
  }
}

LatLng getCurrentLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

String getCurrentAddressFromSharedPrefs() {
  return sharedPreferences.getString('current-address')!;
}

LatLng getTripLatLngFromSharedPrefs(String type) {
  List sourceLocationList =
      json.decode(sharedPreferences.getString('source')!)['location'];
  List destinationLocationList =
      json.decode(sharedPreferences.getString('destination')!)['location'];

  LatLng source = LatLng(sourceLocationList[0], sourceLocationList[1]);
  LatLng destination =
      LatLng(destinationLocationList[0], destinationLocationList[1]);

  if (type == 'source') {
    return source;
  } else {
    return destination;
  }
}

String getSourceAndDestinationPlaceText(String type) {
  String sourceAddress =
      json.decode(sharedPreferences.getString('source')!)['name'];
  String destinationAddress =
      json.decode(sharedPreferences.getString('destination')!)['name'];

  if (type == 'source') {
    return sourceAddress;
  } else {
    return destinationAddress;
  }
}
