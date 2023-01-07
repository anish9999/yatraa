import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DriverLocation with ChangeNotifier {
  final List<Map> _locations = [
    {
      "id": "1",
      "latitude": 27.730531350484114,
      "longitude": 85.34509106747254,
    },
    {
      "id": "2",
      "latitude": 27.71722528698895,
      "longitude": 85.34675633721685,
    },
    {
      "id": "3",
      "latitude": 27.66664777342315,
      "longitude": 85.30824303859612,
    },
    {
      "id": "4",
      "latitude": 27.657974555388606,
      "longitude": 85.32252035198354,
    },
  ];

  List get locations {
    return [..._locations];
  }

  void addLocation() async {
    var response = await Dio().get('$serverUrl/location/14');
    var parsedResponse = {
      "id": response.data['id'],
      "latitude": response.data['lat'],
      "longitude": response.data['lon'],
    };
    _locations.add(parsedResponse);
    notifyListeners();
  }
}
