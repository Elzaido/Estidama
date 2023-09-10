import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';

class RecyclingLocationsMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Jordan's geographic boundaries (latitude and longitude).
    double north = 33.372469;
    double south = 29.185182;
    double east = 39.293083;
    double west = 35.546909;

    // Calculate the center point.
    double centerLat = (north + south) / 2;
    double centerLng = (east + west) / 2;

    // Calculate the zoom level to fit Jordan within the map view.
    double zoomLevel = calculateZoomLevel(
      north: north,
      south: south,
      east: east,
      west: west,
      mapWidth: 400, // Adjust this value based on your map view width.
    );

    List<RecyclingLocation> recyclingLocations = [
      RecyclingLocation('Recycling Center 1', 31.950527, 35.941088),
      RecyclingLocation('Recycling Center 2', 32.016098, 35.878227),
      RecyclingLocation('Recycling Center 3', 32.060983, 35.843164),
      // Add more sample recycling locations here.
    ];

    Set<Marker> _markers = generateRecyclingMarkers(recyclingLocations);

    return Scaffold(
      appBar: defaultAppBar(
          context: context, title: 'نقاط إعادة التدوير في الأردن'),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(centerLat, centerLng), // Center of Jordan.
          zoom: zoomLevel, // Zoom level to fit Jordan within the map.
        ),
        markers: _markers, // Set of markers for recycling locations.
      ),
    );
  }

  // Function to calculate the zoom level based on boundaries and map width.
  double calculateZoomLevel({
    required double north,
    required double south,
    required double east,
    required double west,
    required double mapWidth,
  }) {
    const double zoomN = 0.1; // Adjust this value as needed.
    const double zoomW = 0.1; // Adjust this value as needed.

    double latFraction = (north - south) / 360;
    double lngDiff = east - west;
    double lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    double latZoom = zoomN / latFraction;
    double lngZoom = zoomW / lngFraction;

    double zoom = (latZoom < lngZoom) ? latZoom : lngZoom;

    double equator =
        40075004; // Earth's circumference in meters at the equator.
    double metersPerPixel = equator / 256 / (1 << zoom.toInt());

    double zoomLevel = (log(mapWidth * 360 / lngDiff / metersPerPixel) / ln2);

    return zoomLevel;
  }

  // Function to generate markers for recycling locations.
  Set<Marker> generateRecyclingMarkers(List<RecyclingLocation> locations) {
    Set<Marker> markers = {};

    for (var location in locations) {
      markers.add(
        Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen, // You can customize the marker's color.
          ),
          infoWindow: InfoWindow(
            title: location.name,
          ),
        ),
      );
    }

    return markers;
  }
}

class RecyclingLocation {
  final String name;
  final double latitude;
  final double longitude;

  RecyclingLocation(this.name, this.latitude, this.longitude);
}
