import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidgetDetail extends StatefulWidget {
  final double lat;
  final double lon;
  const MapsWidgetDetail({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<MapsWidgetDetail> createState() => _MapsWidgetDetailState();
}

class _MapsWidgetDetailState extends State<MapsWidgetDetail> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;

  @override
  void initState() {
    super.initState();
    getLocation(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = LatLng(widget.lat, widget.lon);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GoogleMap(
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: dicodingOffice,
              ),
              onMapCreated: (controller) async {
                final info =
                    await geo.placemarkFromCoordinates(widget.lat, widget.lon);
                final place = info[0];
                final street = place.street;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                setState(
                  () {
                    placemark = place;
                  },
                );
                defineMarker(currentPosition, street, address);
              },
            ),
          ),
          if (placemark == null)
            const SizedBox()
          // else
          //   Positioned(
          //     bottom: 16,
          //     right: 16,
          //     left: 16,
          //     child: PlacemarkWidgetDetail(
          //       placemark: placemark!,
          //     ),
          //   ),
        ],
      ),
    );
  }

  void getLocation(double lat, double lon) async {
    final currentPosisition = LatLng(lat, lon);
    final marker = Marker(
      markerId: const MarkerId('Dicoding Id'),
      position: currentPosisition,
      onTap: () => mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentPosisition, 18),
      ),
    );
    markers.add(marker);
  }

  void defineMarker(LatLng latLng, String? street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street ?? '',
        snippet: address,
      ),
    );
    setState(
      () {
        markers.clear();
        markers.add(marker);
      },
    );
  }
}