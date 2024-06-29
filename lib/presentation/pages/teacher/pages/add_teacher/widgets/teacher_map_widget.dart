import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/placemark_widget_teacher.dart';
import 'package:location/location.dart';
class TeacherMapWidget extends StatefulWidget {
  final TextEditingController addressController;
  final Function(LatLng) onLocationChanged; // Tambah properti callback

  const TeacherMapWidget({Key? key, required this.addressController, required this.onLocationChanged}) : super(key: key);

  @override
  _TeacherMapWidgetState createState() => _TeacherMapWidgetState();
}

class _TeacherMapWidgetState extends State<TeacherMapWidget> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  geo.Placemark? placemark;
  final LatLng addOnTech = const LatLng(-6.8957473, 107.6337669); // Ubah lokasi sesuai kebutuhan

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.40,
          child: Center(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: addOnTech,
                    zoom: 18,
                  ),
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) async {
                    final info = await geo.placemarkFromCoordinates(
                        addOnTech.latitude, addOnTech.longitude);
                    final place = info[0];
                    final street = place.street!;
                    final address =
                        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                    setState(() {
                      placemark = place;
                    });
                    defineMarker(addOnTech, street, address);

                    final marker = Marker(
                      markerId: const MarkerId("source"),
                      position: addOnTech,
                    );
                    setState(
                      () {
                        mapController = controller;
                        markers.add(marker);
                      },
                    );
                  },
                  onLongPress: (LatLng latLng) {
                    onLongPressGoogleMap(latLng);
                  },
                  onCameraMove: (CameraPosition position) {
                    widget.onLocationChanged(position.target); // Panggil callback untuk mengirim latLng
                  },
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    child: const Icon(Icons.my_location),
                    onPressed: () {
                      onMyLocationButtonPress();
                    },
                  ),
                ),
                if (placemark == null)
                  const SizedBox()
                else
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: PlacemarkWidgetTeacher(
                      placemark: placemark!,
                      onAddressSelected: (address) {
                        setState(
                          () {
                            widget.addressController.text = address;
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat Guru 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: widget.addressController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan alamat guru . . .',
                ),
                 style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address = '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint("Location services is not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    final info = await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address = '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(latLng, street!, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}

