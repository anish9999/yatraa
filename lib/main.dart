import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatraa/screens/home.dart';
import 'package:yatraa/screens/prepare_ride.dart';
import 'package:yatraa/screens/review_ride.dart';

import 'UI/splash.dart';

late SharedPreferences sharedPreferences;
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
    return MaterialApp(
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
        // ReviewRide.routeName: (context) =>
        //     const ReviewRide(modifiedResponse: {}),
      },
    );
  }
}
