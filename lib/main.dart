// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatraa/providers/bus_stop_location.dart';
import 'package:yatraa/providers/driver_location.dart';
import 'package:yatraa/screens/driver_screen.dart';
import 'package:yatraa/screens/login_screen.dart';
import 'package:yatraa/screens/otp_verification_screen.dart';
import 'package:yatraa/screens/passenger_screen.dart';
import 'package:yatraa/screens/rate_driver_screen.dart';

import '../screens/home.dart';
import '../screens/prepare_ride.dart';

import '../screens/turn_by_turn.dart';

import 'UI/splash.dart';

late SharedPreferences sharedPreferences;
const String MAPBOX_ACCESS_TOKEN =
    "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig";

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //for splash screen
  sharedPreferences = await SharedPreferences
      .getInstance(); //Using shared preference for storage of current user location
  await dotenv.load(
      fileName:
          "assets/config/.env"); //setting up the environment so that our secret key is and added to github and for other feautres of dot_env package
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusStopLocation(),
      child: ChangeNotifierProvider(
        create: (context) => DriverLocation(),
        child: MaterialApp(
          title: 'Yatraa',
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'Quicksand',
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade600),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                enableFeedback: true,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          //initialRoute: LoginScreen.routeName,
          routes: {
            "/": (context) => const Splash(),
            Home.routeName: (context) => const Home(),
            PrepareRide.routeName: (context) => const PrepareRide(),
            // ReviewRide.routeName: (context) => ReviewRide(),
            TurnByTurn.routeName: (context) => const TurnByTurn(),
            DriverScreen.routeName: (context) => const DriverScreen(),
            PassengerScreen.routeName: (context) => const PassengerScreen(),
            OtpVerificationScreen.routeName: (context) =>
                OtpVerificationScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RateDriverScreen.routeName: (context) => const RateDriverScreen(),
          },
        ),
      ),
    );
  }
}
