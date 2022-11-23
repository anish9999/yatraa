//access token is required

import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:yatraa/widgets/app_drawer.dart';
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
  late MapboxMapController controller;
  late bool positive;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildHamburgerMenu() {
    return Positioned(
      left: 20,
      top: 60,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ]),
        child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
    );
  }

  @override
  void initState() {
    //Set initial camera position and current address

    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    positive = getCurrentUserMode();
    super.initState();
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  // String? mapMarker() {
  //   if (positive == true) {
  //     "assets/images/marker.png";
  //   } else {
  //     "assets/images/p_marker.png";
  //   }
  // }

  _onStyleLoadedCallBack() async {
    await controller.addSymbol(SymbolOptions(
      geometry: currentLocation,
      iconSize: 1.5,
      iconImage:
          // positive == true
          //     ? "assets/images/marker.png"
          //     :
          "assets/images/p_marker.png",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Add MapboxMap here and enable user location

          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken:
                "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig",
            // myLocationEnabled: true,
            compassEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallBack,
          ),

          //Hamburger Menu
          buildHamburgerMenu(),

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
          Positioned(
            right: 5,
            bottom: 200,
            child: SizedBox(
              height: 35,
              child: FloatingActionButton(
                onPressed: () {
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(_initialCameraPosition));
                },
                child: const Icon(Icons.my_location),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
