import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  var whichPage = Get.arguments;
  LatLng? selectedLocation; // This will store the selected location.

  // Create a controller for the Google Map.
  late GoogleMapController mapController;

  // Define a Set to hold markers.
  Set<Marker> markers = {};

  // Function to handle map creation and add markers.
  void _onMapCreated(GoogleMapController controller) {
    setState(() async {
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
      // Check location service status.
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        // ignore: use_build_context_synchronously
        showMapDialog();
      }
    });
  }

  void showMapDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'فعل خدمات تحديد الموقع',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            content: const Text(
              'يرجى تمكين خدمات الموقع على هاتفك',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'حسناً',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ComplainsController complainsController = Get.find();
    RecyclingController recyclingController = Get.find();
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'حدد الموقع على الخريطة'),
      body: Stack(
        children: [
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
            myLocationButtonEnabled: true, // Show the user's location button.
            myLocationEnabled: true, // Enable the user's location on the map.
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 20),
              child: button(
                onPressed: () {
                  if (selectedLocation != null) {
                    if (whichPage == 1) {
                      Get.back();
                      Get.toNamed("/complains",
                          arguments: selectedLocation.toString());
                      complainsController.locationSelected.value = true;
                    } else {
                      // Get.back();

                      Get.offNamed("/recyclingform",
                          arguments: selectedLocation.toString());
                      
// print("4444444444444 ${selectedLocation.toString()}");
                      recyclingController.locationSelected.value = true;
                    }
                  } else {
                    // Location is null, handle accordingly (show a message or alert).
                    defaultToast(
                      massage: 'الرجاء تحديد الموقع على الخريطة',
                      state: ToastStates.ERROR,
                    );
                  }
                },
                child: const Text(
                  'تأكيد',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
