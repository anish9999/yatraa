//access token is required

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:yatraa/screens/driver_screen.dart';
import 'package:yatraa/screens/passenger_screen.dart';
import 'package:yatraa/widgets/app_drawer.dart';
import '../helpers/shared_prefs.dart';

import '../main.dart';
import '../screens/prepare_ride.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = "/home-screen";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late bool positive;

  // Widget buildHamburgerMenu() {
  //   return Positioned(
  //     left: 20,
  //     top: 60,
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(22.0),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.black26,
  //               spreadRadius: 1,
  //               blurRadius: 2,
  //               offset: Offset(0, 1.5),
  //             ),
  //           ]),
  //       child: IconButton(
  //         icon: const Icon(Icons.menu),
  //         onPressed: () => scaffoldKey.currentState?.openDrawer(),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    //Set initial camera position and current address

    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
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
