import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';


class ChangeLocationPage extends StatefulWidget {
  static const ROUTE_NAME = "/change-location";
  const ChangeLocationPage({super.key});

  @override
  State<ChangeLocationPage> createState() => _ChangeLocationPageState();
}

class _ChangeLocationPageState extends State<ChangeLocationPage> {
  final TextEditingController _locationController = TextEditingController();
  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Lokasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GooglePlaceAutoCompleteTextField(
              textEditingController: _locationController,
              googleAPIKey:
                  "AIzaSyCrwJlZ6WKybOec-vLvtHzb2AHL3sLwso0", // Ganti dengan kunci API Anda
              inputDecoration: const InputDecoration(
                hintText: "Cari tempat...",
                border: OutlineInputBorder(),
              ),
              countries: ["id"], // Sesuaikan dengan kode negara Anda
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (prediction) async {
                // Dapatkan detail tempat menggunakan prediksi
                List<geo.Location> locations = await locationFromAddress(prediction.description ?? '');
                if (locations.isNotEmpty) {
                  setState(() {
                    selectedLatitude = locations[0].latitude;
                    selectedLongitude = locations[0].longitude;
                    selectedAddress = prediction.description;
                  });
                }
              },
              itemClick: (prediction) async {
                // Saat pengguna memilih item dari daftar, dapatkan detail lokasi
                List<geo.Location> locations = await locationFromAddress(prediction.description ?? '');
                if (locations.isNotEmpty) {
                  setState(() {
                    selectedLatitude = locations[0].latitude;
                    selectedLongitude = locations[0].longitude;
                    selectedAddress = prediction.description;
                  });
                }
                _locationController.text = prediction.description ?? '';
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedLatitude != null && selectedLongitude != null && selectedAddress != null) {
                  Navigator.pop(context, {
                    'latitude': selectedLatitude,
                    'longitude': selectedLongitude,
                    'address': selectedAddress,
                  });
                }
              },
              child: const Text('Simpan Lokasi'),
            ),
          ],
        ),
      ),
    );
  }
}
