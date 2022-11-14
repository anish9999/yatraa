import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const routeName = "/home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Add MapboxMap here and enable user location
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
                      const Text(
                        'Hi there!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const Text('You are currently here:'),
                      const Text('<Show the current address here>',
                          style: TextStyle(color: Colors.indigo)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        //  Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => const PrepareRide())),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Where do you wanna go today?'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
