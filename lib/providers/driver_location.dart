import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class DriverLocation with ChangeNotifier {
  final List<Map> _locations = [
    // {
    //   "id": "1",
    //   "latitude": 27.730531350484114,
    //   "longitude": 85.34509106747254,
    // },
    // {
    //   "id": "2",
    //   "latitude": 27.71722528698895,
    //   "longitude": 85.34675633721685,
    // },
    // {
    //   "id": "3",
    //   "latitude": 27.66664777342315,
    //   "longitude": 85.30824303859612,
    // },
    // {
    //   "id": "4",
    //   "latitude": 27.657974555388606,
    //   "longitude": 85.32252035198354,
    // },
  ];

  List get locations {
    return [..._locations];
  }

  void addLocation() async {
    var response = await Dio().get('$serverUrl/location/3/live/');
    print(response);
    var parsedResponse = {
      // "id": response.data['user'].toString(),
      "latitude": response.data[0]['lat'],
      "longitude": response.data[0]['lon'],
    };
    print(parsedResponse);
    _locations.add(parsedResponse);
    notifyListeners();
  }

  // void updateLocation(LatLng lon, LatLng lat) {
  //   _locations.first['latitude'] = lat;
  //   _locations.first['longitude'] = lat;
  //   notifyListeners();
  // }
}
