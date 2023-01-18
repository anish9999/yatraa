import 'package:dio/dio.dart';
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
  final Dio _dio = Dio();
  String url = "$serverUrl/location/create/3/";
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

  // _sendLocationToServer(currentLocation) {
  // print(currentLocation.position);
  // double lat = currentLocation.latitude;
  // double lon = currentLocation.longitude;
  // String data = "{\"lon\":\"$lon\",\"lat\":\"$lat\"}";
  // Timer.periodic(const Duration(seconds: 1),
  //     (Timer t) => _dio.post(Uri.parse(url).toString(), data: data));
  // }

  _onStyleLoadedCallBack() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: currentLocation,
        iconSize: 1.5,
        draggable: true,
        iconImage: "assets/images/marker.png",
      ),
    );
    controller.onSymbolTapped.add((Symbol symbol) {
      symbol.options.geometry!;
      double lat = symbol.options.geometry!.latitude;
      double lon = symbol.options.geometry!.longitude;
      String data = "{\"lon\":\"$lon\",\"lat\":\"$lat\"}";
      // print(data);
      _dio.post(Uri.parse(url).toString(), data: data);
    });
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
            dragEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            accessToken: MAPBOX_ACCESS_TOKEN,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            myLocationRenderMode: MyLocationRenderMode.GPS,
            onUserLocationUpdated: (location) {
              double lat = currentLocation.latitude;
              double lon = currentLocation.longitude;
              String data = "{\"lon\":\"$lon\",\"lat\":\"$lat\"}";
              print(data);
              _dio.post(Uri.parse(url).toString(), data: data);
            },
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            // onStyleLoadedCallback: _onStyleLoadedCallBack,
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
