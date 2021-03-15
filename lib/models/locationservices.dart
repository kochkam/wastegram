import 'package:location/location.dart';
import 'package:flutter/material.dart';

// https://pub.dev/packages/location
class WasteLocation {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<LocationData> getlocation() async {
    _serviceEnabled = await location.serviceEnabled(); 
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService(); //request services
      if (!_serviceEnabled) {
        return Future.error("Location services are disabled");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission(); //get permission
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error("Location permissions are denied");
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}
