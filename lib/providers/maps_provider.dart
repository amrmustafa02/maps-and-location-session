import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
   GoogleMapController? mapController;

   Set<Marker> markers = {
    const Marker(
        markerId: MarkerId("marker1"), position: LatLng(30.057595, 31.357501))
  };

   final Location _location = Location();

   permissionStatusGranted() async {
    var permissionStatus = await _location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

   locationServiceEnabled() async {
    var locationEnabled = await _location.serviceEnabled();
    if (!locationEnabled) {
      locationEnabled = await _location.requestService();
    }
    return locationEnabled;
  }

   getCurrentLocation() async {
    var permissionGranted = await permissionStatusGranted();
    var locationEnabled = await locationServiceEnabled();
    if (permissionGranted && locationEnabled) {
      print("has access");

      var userLocation = await _location.getLocation();

      mapController!.animateCamera(CameraUpdate.newLatLng(
          LatLng(userLocation.latitude!, userLocation.longitude!)));

      markers.add(
        Marker(
          markerId: const MarkerId("marker1"),
          position: LatLng(userLocation.latitude!, userLocation.longitude!),
        ),
      );


      print("Latitude: ${userLocation.latitude}");
      print("Longitude: ${userLocation.longitude}");
      print("altitude: ${userLocation.altitude}");
      print("accuracy: ${userLocation.accuracy}");
      print("speed: ${userLocation.speed}");
      print("speed_accuracy: ${userLocation.speedAccuracy}");
      print("heading: ${userLocation.heading}");
      print("time: ${userLocation.time}");
    }
    notifyListeners();
  }

   trackLocation() async {
    _location.onLocationChanged.listen((LocationData userLocation) {
      print("Latitude: ${userLocation.latitude}");
      print("Longitude: ${userLocation.longitude}");
      print("altitude: ${userLocation.altitude}");
      print("accuracy: ${userLocation.accuracy}");
      print("speed: ${userLocation.speed}");
      print("speed_accuracy: ${userLocation.speedAccuracy}");
      print("heading: ${userLocation.heading}");
      print("time: ${userLocation.time}");
      mapController!.animateCamera(CameraUpdate.newLatLng(
          LatLng(userLocation.latitude!, userLocation.longitude!)));

      markers.add(
        Marker(
          markerId: const MarkerId("marker1"),
          position: LatLng(userLocation.latitude!, userLocation.longitude!),
        ),
      );
      notifyListeners();
    });
  }
}
