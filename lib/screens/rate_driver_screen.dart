import 'package:flutter/material.dart';
import 'package:yatraa/UI/rate_ride.dart';

class RateDriverScreen extends StatefulWidget {
  static const routeName = '/rate-driver-screen';
  const RateDriverScreen({super.key});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return const RateRide();
  }
}
