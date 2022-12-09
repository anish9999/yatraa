import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

import '../providers/driver_location.dart';
import '../main.dart';
import '../screens/review_journey.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hamburger_menu.dart';
import '../helpers/mapbox_handler.dart';
import '../screens/prepare_ride.dart';
import '../helpers/shared_prefs.dart';

class PassengerScreen extends StatefulWidget {
  static const routeName = '/passenger-screen';

  const PassengerScreen({super.key});

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();
  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  late List<CameraPosition> driverLocationCoordinates;

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

  _onStyleLoadedCallback() async {
    for (CameraPosition coordinates in driverLocationCoordinates) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: coordinates.target,
          iconSize: 1.5,
          iconImage: "assets/images/marker.png",
        ),
      );
    }
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

//   Future<LatLng> getSymbolLatLng(Symbol symbol) async {
//   return symbol.options.geometry!;
// }

  void _onSymbolTapped(Symbol symbol) {
    late LatLng destinationLatLng;
    destinationLatLng = symbol.options.geometry!;
    _showBottomSheet(destinationLatLng, symbol.id);
  }

  _showBottomSheet(LatLng destinationLatLng, String id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          LatLng sourceLatLng = currentLocation;
          return SizedBox(
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  icon: const Icon(Icons.airline_seat_recline_extra_sharp),
                  onPressed: () async {
                    Map modifiedResponse = await getDirectionsAPIResponse(
                        sourceLatLng, destinationLatLng);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewJourney(
                          modifiedResponse: modifiedResponse,
                          sourceAddress: sourceLatLng,
                          destAddress: destinationLatLng,
                        ),
                      ),
                    );
                  },
                  label: const Text('Review Journey'),
                ),
              ],
            ),
          );
        });
  }

  Widget buildPassengerScreenBottom() {
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
                  'Hi there!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('You are currently here:'),
                Text(currentAddress,
                    style: const TextStyle(color: Colors.indigo)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(PrepareRide.routeName);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final driverLocationData = Provider.of<DriverLocation>(context);
    final driverLocation = driverLocationData.locations;

    driverLocationCoordinates = List<CameraPosition>.generate(
      driverLocation.length,
      (index) => CameraPosition(
        target: LatLng(
            double.parse(driverLocation[index]['coordinates']['latitude']),
            double.parse(driverLocation[index]['coordinates']['longitude'])),
        zoom: 15,
      ),
    );
    // print(driverLocationCoordinates);

    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Add MapboxMap here and enable user location

          MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken: MAPBOX_ACCESS_TOKEN,
            compassEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
          ),

          //Hamburger Menu
          HamburgerMenu(scaffoldKey),

          buildPassengerScreenBottom(),

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
  }
}
