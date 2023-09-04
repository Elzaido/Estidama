import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LatLng? selectedLocation; // This will store the selected location.

  // Create a controller for the Google Map.
  late GoogleMapController mapController;

  // Define a Set to hold markers.
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  // Function to handle map creation and add markers.
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;

      // Add a marker for an initial location (if needed).
      markers.add(
        const Marker(
          markerId: MarkerId('initialMarker'),
          position:
              LatLng(40.7128, -74.0060), // Example coordinates (New York City).
          infoWindow: InfoWindow(
            title: 'Initial Location',
            snippet: 'This is an example location.',
          ),
        ),
      );

      // Move the camera to the initial location.
      mapController.moveCamera(
        CameraUpdate.newLatLngZoom(const LatLng(31.9465296, 35.8841449), 14.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'حدد مكان البلاغ'),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(40.7128, -74.0060), // Initial coordinates.
            zoom: 14.0,
          ),
          markers: markers,
          onTap: (LatLng position) {
            // Remove existing markers and add a new one at the tapped position.
            setState(() {
              markers.clear();
              markers.add(
                Marker(
                  markerId: MarkerId(position.toString()),
                  position: position,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Selected Location',
                    snippet: 'This is your selected location.',
                  ),
                ),
              );

              // Update the selectedLocation.
              selectedLocation = position;
            });
          },
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 20),
              child: button(
                  onPressed: () {
                    // Return the selected location to the previous screen.
                    Navigator.pop(context, selectedLocation);
                  },
                  child: const Text(
                    'تم تحديد المكان',
                    style: TextStyle(fontFamily: 'Cairo'),
                  )),
            ))
      ]),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: mainColor,
      //   onPressed: () {
      //     // Return the selected location to the previous screen.
      //     Navigator.pop(context, selectedLocation);
      //   },
      //   child: const Icon(Icons.check),
      // ),
    );
  }
}