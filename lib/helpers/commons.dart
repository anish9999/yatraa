import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDropOffTime(num duration) {
  int minutes = (duration / 60).round();
  int seconds = (duration % 60).round();
  DateTime tripEndDateTime =
      DateTime.now().add(Duration(minutes: minutes, seconds: seconds));
  String dropOffTime = DateFormat.jm().format(tripEndDateTime);
  return dropOffTime;
}

double getMoney(double distance) {
  if (distance > 0 && distance <= 5) {
    return 20;
  } else if (distance > 5 && distance <= 10) {
    return 25;
  } else if (distance > 10 && distance <= 15) {
    return 30;
  } else if (distance > 15 && distance <= 20) {
    return 33;
  } else if (distance > 20) {
    return 38;
  } else {
    return 0;
  }
}
