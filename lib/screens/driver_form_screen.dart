import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yatraa/main.dart';

import '../screens/driver_screen.dart';
import '../model/driver_information.dart';
import '../widgets/image_input.dart';

class DriverFormScreen extends StatefulWidget {
  const DriverFormScreen({super.key});
  static const routeName = "/driver-form";
  @override
  State<DriverFormScreen> createState() => _DriverFormScreenState();
}

class _DriverFormScreenState extends State<DriverFormScreen> {
  bool isBlueBook = true;
  final _form = GlobalKey<FormState>();
  File? _pickedBlueBookImage;
  File? _pickedLiscenseImage;

  DriverInformation editedInformation = DriverInformation();

  void _selectBlueBookImage(File pickedBlueBookImage) {
    _pickedBlueBookImage = pickedBlueBookImage;
  }

  void _selectLiscenseImage(File pickedLiscenseImage) {
    _pickedLiscenseImage = pickedLiscenseImage;
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid ||
        _pickedBlueBookImage == null ||
        _pickedLiscenseImage == null) {
      return;
    } else {
      editedInformation.bluebookImage = _pickedBlueBookImage;
      editedInformation.liscenseImage = _pickedLiscenseImage;
      _form.currentState!.save();
      sharedPreferences.setString("driver-name", editedInformation.name!);
      sharedPreferences.setString(
          "vehicle-number", editedInformation.vehicleNumber!);
      sharedPreferences.setString(
          "liscense-number", editedInformation.liscenseNumber!);
      sharedPreferences.setBool("form-submitted", true);
      // sharedPreferences.setString(
      //     "bluebook-image", editedInformation.bluebookImage.toString());
      // sharedPreferences.setString(
      //     "liscense-image", editedInformation.liscenseImage.toString());
      Navigator.of(context).pushNamed(DriverScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: sharedPreferences.getString("driver-name"),
                decoration: const InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  editedInformation.name = value;
                },
              ),
              TextFormField(
                initialValue: sharedPreferences.getString("vehicle-number"),
                decoration: const InputDecoration(labelText: "Vehicle Number"),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your vehicle number';
                  }
                  return null;
                },
                onSaved: (value) {
                  editedInformation.vehicleNumber = value;
                },
              ),
              TextFormField(
                initialValue: sharedPreferences.getString("liscense-number"),
                decoration: const InputDecoration(labelText: "Liscense Number"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your liscense number';
                  }
                  return null;
                },
                onSaved: (value) {
                  editedInformation.liscenseNumber = value;
                },
              ),
              const SizedBox(
                height: 17,
              ),
              ImageInput(isBlueBook, _selectBlueBookImage),
              const SizedBox(
                height: 17,
              ),
              ImageInput(!isBlueBook, _selectLiscenseImage),
              const SizedBox(
                height: 17,
              ),
              ElevatedButton(
                  onPressed: _saveForm, child: const Text("Submit Form")),
            ],
          ),
        ),
      ),
    );
  }
}
