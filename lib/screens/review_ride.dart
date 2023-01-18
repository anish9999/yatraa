//access token is required

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:yatraa/providers/driver_location.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../helpers/commons.dart';
import '../main.dart';
import '../providers/bus_stop_location.dart';
import '../widgets/review_ride_bottom_sheet.dart';

class ReviewRide extends StatefulWidget {
  final Map modifiedResponse;
  const ReviewRide({Key? key, required this.modifiedResponse})
      : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  late List<CameraPosition> busStopLocationCoordinates;
  late List<CameraPosition> driverLocationCoordinates;

  // Directions API response related
  late String distance;
  late String dropOffTime;
  late Map geometry;

  final Dio _dio = Dio();
  String url = "$serverUrl/location/create/2/";

  @override
  void initState() {
    // initialise distance, dropOffTime, geometry
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
      target: getCenterCoordinatesForPolyline(geometry),
      zoom: 14,
    );

    for (String type in ['source', 'destination']) {
      _kTripEndPoints
          .add(CameraPosition(target: getTripLatLngFromSharedPrefs(type)));
    }
    super.initState();
  }

  _initialiseDirectionsResponse() {
    distance = (widget.modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
    geometry = widget.modifiedResponse['geometry'];
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    // Timer.periodic(const Duration(seconds: 1),
    //     (Timer t) => _dio.post(Uri.parse(url).toString(), data: data));
    for (CameraPosition coordinates in busStopLocationCoordinates) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: coordinates.target,
          iconSize: 1.5,
          iconImage: "assets/images/bus-stop.png",
        ),
      );
      // print(coordinates.target);
    }
    for (CameraPosition coordinates in driverLocationCoordinates) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: coordinates.target,
          iconSize: 1.5,
          iconImage: "assets/images/marker.png",
        ),
      );
    }

    // controller.onSymbolTapped.add(_onSymbolTapped);
  }

  // void _onSymbolTapped(Symbol symbol) {
  //   print("$symbol tapped");
  // }

  @override
  Widget build(BuildContext context) {
    final busStopLocationData = Provider.of<BusStopLocation>(context);
    final busStopLocation = busStopLocationData.locations;

    busStopLocationCoordinates = List<CameraPosition>.generate(
      busStopLocation.length,
      (index) => CameraPosition(
        target: LatLng(busStopLocation[index]['latitude'],
            busStopLocation[index]['longitude']),
        zoom: 15,
      ),
    );

    final driverLocation = Provider.of<DriverLocation>(context).locations;
    driverLocationCoordinates = List<CameraPosition>.generate(
      driverLocation.length,
      (index) => CameraPosition(
        target: LatLng(driverLocation[index]['latitude'],
            driverLocation[index]['longitude']),
        zoom: 15,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Ride'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: MAPBOX_ACCESS_TOKEN,
                initialCameraPosition: _initialCameraPosition,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              ),
            ),
            reviewRideBottomSheet(context, distance, dropOffTime),
            Positioned(
              right: 5,
              bottom: 230,
              child: SizedBox(
                height: 35,
                child: FloatingActionButton(
                  onPressed: () {
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(_initialCameraPosition));
                  },
                  child: const Icon(Icons.my_location),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
