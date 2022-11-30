// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:pinput/pinput.dart';
import '../screens/home.dart';
import '../screens/login_screen.dart';

// ignore: must_be_immutable
class OtpVerificationScreen extends StatelessWidget {
  static const routeName = '/Otp-verification-screen';
  var code = "";

  /// Determine the current position of the device..
  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromARGB(255, 132, 134, 136),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
  );

  OtpVerificationScreen({super.key});

  void loginScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => loginScreen(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/login_page_img.png",
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone before getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                length: 6,
                onChanged: (value) => code = value,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // PhoneAuthCredential credential =
                      //     PhoneAuthProvider.credential(
                      //         verificationId: LoginScreen.verify,
                      //         smsCode: code);

                      // Sign the user in (or link) with the credential

                      //  await auth.signInWithCredential(credential);
                      //for current location
                      //  Position position = await _determinePosition();

                      Navigator.of(context).pushNamed(Home.routeName);
                      // arguments: position);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 4),
                        content: Text('Please enter the correct OTP!'),
                      ));
                    }
                  },
                  child: const Text('Verify Phone Number'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => loginScreen(context),
                    child: const Text(
                      "Edit Phone Number?",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
