import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yatraa/helpers/shared_prefs.dart';
import '../helpers/mapbox_handler.dart';

import '../providers/driver_location.dart';
import '../screens/review_journey.dart';

// ignore: non_constant_identifier_names
Widget JourneyReviewBottomSheet(context, sourceLatLng, destLatLng,
    modifiedResponse, distance, dropOffTime) {
  final sourceAddress = getCurrentAddressFromSharedPrefs();
  final destAddress = Provider.of<DriverLocation>(context).locations;

  return Positioned(
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
                  '$sourceAddress➡ $destAddress',
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
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('$distance km, $dropOffTime drop off'),
                  ),
                ),
                FloatingActionButton.extended(
                  icon: const Icon(Icons.directions_walk_rounded),
                  onPressed: () async {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewJourney(
                          modifiedResponse: modifiedResponse,
                          sourceAddress: sourceLatLng,
                          destAddress: destLatLng,
                        ),
                      ),
                    );
                  },
                  label: const Text('Review Journey'),
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context)
                //         .pushNamed(TurnByTurn.routeName);
                //   },
                //   style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.all(20)),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Start your journey now'),
                //       ]),
                // ),
              ]),
        ),
      ),
    ),
  );
}
