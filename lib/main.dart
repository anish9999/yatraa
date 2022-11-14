import 'package:flutter/material.dart';

import 'UI/splash.dart';

void main() async {
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
        "/": (context) => Splash(),
      },
    );
  }
}
