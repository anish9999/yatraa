import 'dart:io';

class DriverInformation {
  String? name;
  String? vehicleNumber;
  String? liscenseNumber;
  File? bluebookImage;
  File? liscenseImage;

  DriverInformation({
    this.name,
    this.vehicleNumber,
    this.liscenseNumber,
    this.bluebookImage,
    this.liscenseImage,
  });
}
