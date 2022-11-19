//access token is required

import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import '../helpers/shared_prefs.dart';
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

  @override
  void initState() {
    //Set initial camera position and current address

    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Add MapboxMap here and enable user location

          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken:
                "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig",
            myLocationEnabled: true,
            compassEnabled: true,
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Hi there!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      Text(currentAddress,
                          style: const TextStyle(color: Colors.indigo)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PrepareRide.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Where do you wanna go today?'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
