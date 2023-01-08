import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login-page';
  static String verify = "";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumber = TextEditingController();
  var countryCode = "+977";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                height: 25,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          Text(countryCode),
                          const SizedBox(
                            width: 3,
                          ),
                          Image.asset(
                            "assets/images/Nepal_flag.png",
                            height: 13,
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countryCode + phoneNumber.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginScreen.verify = verificationId;
                        Navigator.of(context)
                            .pushNamed(OtpVerificationScreen.routeName);
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: const Text('Send the OTP'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
