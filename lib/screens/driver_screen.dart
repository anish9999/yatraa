import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../widgets/app_drawer.dart';
import '../widgets/hamburger_menu.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';

class DriverScreen extends StatefulWidget {
  static const routeName = "/driver-screen";
  const DriverScreen({super.key});
  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    //Set initial camera position and current address
    _initialCameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    currentAddress = getCurrentAddressFromSharedPrefs();
    super.initState();
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallBack() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: currentLocation,
        iconSize: 1.5,
        iconImage: "assets/images/marker.png",
      ),
    );
  }

  Widget buildDriverScreenBottom() {
    return Positioned(
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
                  'Hello there!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('Your vehicle is currently here:'),
                Text(currentAddress,
                    style: const TextStyle(color: Colors.indigo)),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken: MAPBOX_ACCESS_TOKEN,
            compassEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallBack,
          ),
          hamburgerMenu(scaffoldKey),
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
          buildDriverScreenBottom(),
        ],
      ),
    );
  }
}
