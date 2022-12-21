//access token is required

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../screens/driver_screen.dart';
import '../screens/passenger_screen.dart';

import '../helpers/shared_prefs.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = "/home-screen";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;

  late MapboxMapController controller;
  late bool positive;

  @override
  void initState() {
    //Set initial camera position and current address

    currentAddress = getCurrentAddressFromSharedPrefs();
    positive = getCurrentUserMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: positive == true ? const DriverScreen() : const PassengerScreen(),
    );
  }
}
