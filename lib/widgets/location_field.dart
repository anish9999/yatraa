import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:yatraa/helpers/mapbox_handler.dart';
import 'package:yatraa/main.dart';
import 'package:yatraa/screens/prepare_ride.dart';

import '../helpers/shared_prefs.dart';

class LocationField extends StatefulWidget {
  final bool isDestination;
  final TextEditingController textEditingController;

  const LocationField({
    Key? key,
    required this.isDestination,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  Timer? searchOnStoppedTyping;
  String query = '';

  _onChangeHandler(value) {
    PrepareRide.of(context)?.isLoadingState = true;

    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(() => searchOnStoppedTyping =
        Timer(const Duration(seconds: 1), () => _searchHandler(value)));
  }

  _searchHandler(String value) async {
    List response = await getParsedResponseForQuery(value);

    // Set responses and isDestination in parent
    // ignore: use_build_context_synchronously
    PrepareRide.of(context)?.responsesState = response;
    // ignore: use_build_context_synchronously
    PrepareRide.of(context)?.isResponseForDestinationState =
        widget.isDestination;
    setState(() => query = value);
  }

  _useCurrentLocationButtonHandler() async {
    if (!widget.isDestination) {
      LatLng currentLocation = getCurrentLatLngFromSharedPrefs();

      var response = await getParsedReverseGeocoding(currentLocation);
      sharedPreferences.setString(
          'source',
          json.encode(
              response)); //  Store encoded response in shared preferences
      String place = response['place'];
      widget.textEditingController.text =
          place; // 2. Set the text editing controller to the address
    }
  }

  @override
  Widget build(BuildContext context) {
    String placeholderText = widget.isDestination ? 'Where to?' : 'Where from?';
    IconData? iconData = !widget.isDestination ? Icons.my_location : null;
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: CupertinoTextField(
          controller: widget.textEditingController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          placeholder: placeholderText,
          placeholderStyle: GoogleFonts.rubik(color: Colors.indigo[300]),
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          onChanged: _onChangeHandler,
          suffix: IconButton(
              onPressed: () => _useCurrentLocationButtonHandler(),
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
              icon: Icon(iconData, size: 16))),
    );
  }
}
