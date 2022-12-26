import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  bool isBlueBook;
  ImageInput(this.isBlueBook, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No image taken",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showImageViewer(
                      context,
                      widget.isBlueBook
                          ? Image.asset(
                              "assets/images/bluebook.jpg",
                              fit: BoxFit.cover,
                            ).image
                          : Image.asset(
                              "assets/images/liscense.jpg",
                              fit: BoxFit.cover,
                            ).image);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: widget.isBlueBook
                      ? Image.asset(
                          "assets/images/bluebook.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/liscense.jpg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.camera),
                label: widget.isBlueBook
                    ? const Text('Take bluebook image as shown')
                    : const Text('Take liscense image as shown'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
