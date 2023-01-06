import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart" as path;
import 'package:path_provider/path_provider.dart' as syspath;

// ignore: must_be_immutable
class ImageInput extends StatefulWidget {
  bool isBlueBook;
  final Function selectImage;
  File? pickedImage;

  ImageInput(this.isBlueBook, this.selectImage, this.pickedImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showImageViewer(context, Image.file(_storedImage!).image);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            alignment: Alignment.center,
            child: widget.pickedImage != null
                ? Image.file(
                    widget.pickedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : _storedImage != null
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
                onPressed: _takePicture,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
