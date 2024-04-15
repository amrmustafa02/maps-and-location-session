import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/maps_provider.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapsProvider>(context);
    print("build maps");
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.green,
              ),
            ),
            onPressed: () {
              provider.getCurrentLocation();
            },
            icon: const Icon(
              Icons.location_searching_rounded,
            ),
          ),
          IconButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.green,
              ),
            ),
            onPressed: () {
              provider.trackLocation();
            },
            icon: const Icon(
              Icons.track_changes_rounded,
            ),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        markers: provider.markers,
        onMapCreated: (controller) {
          provider.mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.057595, 31.357501),
          zoom: 15,
        ),
      ),
    );
  }
}
