import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../providers/driver_location.dart';
import '../screens/review_ride.dart';

//import '../screens/review_ride.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.airline_seat_recline_extra_sharp),
      onPressed: () async {
        // Get directions API response and pass to modified response

        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');

        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        // ignore: use_build_context_synchronously
        Provider.of<DriverLocation>(context, listen: false).addLocation();
        // ignore: use_build_context_synchronously
        Timer(const Duration(seconds: 5), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      ReviewRide(modifiedResponse: modifiedResponse)));
        });
      },
      label: const Text('Review Ride'));
}
