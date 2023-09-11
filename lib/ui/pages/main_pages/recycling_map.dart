import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';

class RecyclingLocationsMap extends StatelessWidget {
  const RecyclingLocationsMap({super.key});

  @override
  Widget build(BuildContext context) {
    // Jordan's geographic boundaries (latitude and longitude).
    double north = 33.606000;
    double south = 29.185182;
    double east = 38.293083;
    double west = 34.546909;

    // Calculate the center point.
    // double centerLat = (north + south) / 2;
    // double centerLng = (east + west) / 2;

    double centerLat = 31.170252645392356;
    double centerLng = 35.823778370521694;

    // Calculate the zoom level to fit Jordan within the map view.
    double zoomLevel = calculateZoomLevel(
      north: north,
      south: south,
      east: east,
      west: west,
      mapWidth: 400, // Adjust this value based on your map view width.
    );
    List<RecyclingLocation> recyclingLocations = [
      // Irbid:
      RecyclingLocation(
          'النميري لإعادة تدوير الورق', 32.57361440590045, 35.872996694616994),
      RecyclingLocation('الشهم لاعادة التدوير النفايات الالكترونية',
          32.55205847957671, 35.850663166234696),
      RecyclingLocation(
          'البيرة للحديد و المعادن', 32.51521579790277, 35.95177506902044),
      RecyclingLocation('شركة مالك سعيد لإعادة التدوير', 32.52311504082933,
          35.94679353104842),

      // Amman:
      RecyclingLocation('Recycling in Amman - Green Spot', 31.95386472457919,
          35.93102884018464),
      RecyclingLocation(
          'زيادات لإعادة التدوير', 31.956303990058615, 35.930888600104566),
      RecyclingLocation('مركز كوزمو لإعادة التدوير', 31.952348, 35.5664211),
      RecyclingLocation(
          'City Mall Green Centre', 31.981762865830817, 35.839442066851674),
      RecyclingLocation(
          'مركز اعادة تدوير كراج كوزمو', 31.953492748776654, 35.85494092832787),
      RecyclingLocation('OXFAM Recycling Center-District 8', 32.28129738180006,
          36.33929422832786),
      RecyclingLocation('T bottle', 31.954677186787176, 35.92642703627925),
      RecyclingLocation('مؤسسة البيئة الجيده لتدوير البلاستيك',
          31.842832490111753, 36.06987572832786),

      // Aqaba
      RecyclingLocation('مركز العقبة لتدوير الورق والكرتون', 29.4564144155158,
          35.03451049093875),
      RecyclingLocation('مؤسسة العقبه لاعادة تدوير الكرتون والورق',
          29.61055079513394, 35.057169791216275),
      RecyclingLocation('المدينه الخضراء لإعادة التدوير', 29.515587543990552,
          35.01253783612419),

      //Ma'an
      RecyclingLocation('MRC (Ma\'an Recycling Center)', 30.199888262122048,
          35.824531489899606)
    ];

    Set<Marker> markers = generateRecyclingMarkers(recyclingLocations);

    return Scaffold(
      appBar: defaultAppBar(
          context: context, title: 'نقاط إعادة التدوير في الأردن'),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(centerLat, centerLng), // Center of Jordan.
          zoom: zoomLevel, // Zoom level to fit Jordan within the map.
        ),
        markers: markers, // Set of markers for recycling locations.
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
    const double zoomN = 0.1235; // Adjust this value as needed.
    const double zoomW = 0.1235; // Adjust this value as needed.

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
            BitmapDescriptor.hueRed, // You can customize the marker's color.
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
