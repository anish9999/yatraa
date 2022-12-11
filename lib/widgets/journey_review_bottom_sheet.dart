import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/shared_prefs.dart';
import '../providers/driver_location.dart';
import '../screens/review_journey.dart';

// ignore: non_constant_identifier_names
Widget JourneyReviewBottomSheet(context, sourceLatLng, destLatLng,
    modifiedResponse, distance, dropOffTime) {
  final sourceAddress = getCurrentAddressFromSharedPrefs();

  print(destLatLng.latitude);
  print(destLatLng.longitude);
  final destAddress =
      Provider.of<DriverLocation>(context).locations.contains(destLatLng);

  return SizedBox(
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
                '${sourceAddress.substring(0, sourceAddress.indexOf(","))} ➡ $destAddress',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.indigo),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  leading: const CircleAvatar(
                      radius: 25, child: Icon(Icons.directions_walk_outlined)),
                  title: const Text('Journey Review',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    children: [
                      Text('$distance km,Can reach there by $dropOffTime'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
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
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.directions_walk_outlined),
                    Text('Review Journey'),
                  ],
                ),
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
  );
}
