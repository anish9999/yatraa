import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/dio_exceptions.dart';
import '../helpers/shared_prefs.dart';
import '../main.dart';
import '../screens/driver_screen.dart';
import '../screens/passenger_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool positive = getCurrentUserMode();
  LatLng currentLocation = getCurrentLatLngFromSharedPrefs();

  Dio _dio = Dio();

  Widget buildDrawerHeader() {
    // print(currentLocation);
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage: positive == true
                  ? const AssetImage("assets/images/driver.jpg")
                  : const AssetImage("assets/images/passenger.jpg"),
              radius: 44),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hello there fellow",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  positive == true ? "driver" : "passenger",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: buildDrawerHeader(),
          ),
          AnimatedToggleSwitch<bool>.dual(
            current: positive,
            first: false,
            second: true,
            dif: 121.0,
            borderColor: Colors.transparent,
            borderWidth: 5.0,
            height: 55,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1.5),
              ),
            ],
            onChanged: (b) {
              setState(() {
                positive = b;
                sharedPreferences.setBool('user-mode', positive);
                if (positive == true) {
                  //Future getDriverLocation() async {
                  double lat = currentLocation.latitude;
                  double lon = currentLocation.longitude;
                  //  print(lat);
                  //print(lon);

                  String data = "{\"lon\":\"$lon\",\"lat\":\"$lat\"}";
                  // print(data);

                  // print(query);
                  String url = "https://yatraa.herokuapp.com/location/create";

                  url = Uri.parse(url).toString();

                  //  try {
                  //  _dio.options.contentType = Headers.jsonContentType;
                  //  final Response response =
                  //  await
                  _dio.post(url, data: data);

                  //  return response.data;
                  // } catch (e) {
                  //   final errorMessage =
                  //       DioExceptions.fromDioError(e as DioError).toString();
                  //   debugPrint(errorMessage);
                  // }
                  // }

                  Navigator.of(context).pushNamed(DriverScreen.routeName);
                } else {
                  Navigator.of(context).pushNamed(PassengerScreen.routeName);
                }
              });
            },
            iconBuilder: (value) => value
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      "assets/images/driver.jpg",
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset("assets/images/passenger.jpg")),
            textBuilder: (value) => value
                ? const Center(
                    child: Text(
                      "Driver's Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "Passenger's Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
