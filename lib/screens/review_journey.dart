//access token is required

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../screens/turn_by_turn.dart';
import '../helpers/mapbox_handler.dart';
import '../helpers/commons.dart';
import '../main.dart';

class ReviewJourney extends StatefulWidget {
  final Map modifiedResponse;
  final LatLng sourceAddress;
  final LatLng destAddress;
  const ReviewJourney({
    Key? key,
    required this.modifiedResponse,
    required this.sourceAddress,
    required this.destAddress,
  }) : super(key: key);

  @override
  State<ReviewJourney> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewJourney> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  late String distance;
  late String dropOffTime;
  late Map geometry;

  @override
  void initState() {
    // initialise distance, dropOffTime, geometry
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
      target: getCenterCoordinatesForPolyline(geometry),
      zoom: 15,
    );
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
    for (int i = 0; i < _kTripEndPoints.length; i++) {
      // String iconImage = i == 0 ? 'circle' : 'square';
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
          iconSize: 0.1,
          //  iconImage: "assets/icon/$iconImage.png",
        ),
      );
    }
    _addSourceAndLineLayer();
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.green.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Journey'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: MAPBOX_ACCESS_TOKEN,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                // minMaxZoomPreference: const MinMaxZoomPreference(11, 11),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$widget.sourceAddress ➡ $widget.destAddress',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.indigo),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              tileColor: Colors.grey[200],
                              leading: CircleAvatar(
                                radius: 19,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(19),
                                  child: Image.asset(
                                    'assets/images/bus.png',
                                  ),
                                ),
                              ),
                              title: const Text('Journey Review',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle:
                                  Text('$distance km, $dropOffTime drop off'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(TurnByTurn.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Start your journey now'),
                                ]),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
