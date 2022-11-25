import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

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

  Widget buildDrawerHeader() {
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
