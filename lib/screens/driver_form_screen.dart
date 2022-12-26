import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class DriverFormScreen extends StatefulWidget {
  const DriverFormScreen({super.key});
  static const routeName = "/driver-form";
  @override
  State<DriverFormScreen> createState() => _DriverFormScreenState();
}

class _DriverFormScreenState extends State<DriverFormScreen> {
  bool isBlueBook = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Vehicle Number"),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Liscense Number"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 17,
              ),
              ImageInput(isBlueBook),
              const SizedBox(
                height: 17,
              ),
              ImageInput(!isBlueBook),
            ],
          ),
        ),
      ),
    );
  }
}
