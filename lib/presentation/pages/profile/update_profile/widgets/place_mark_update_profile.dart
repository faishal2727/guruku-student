// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:guruku_student/common/themes/themes.dart';

class PlacemarkWidgetUpdateProfile extends StatelessWidget {
  final geo.Placemark placemark;
  final Function(String) onAddressSelected;

  const PlacemarkWidgetUpdateProfile({
    Key? key,
    required this.placemark,
    required this.onAddressSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                placemark.street!,
                style: AppTextStyle.body3.setBold(),
              ),
              Text(
                '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                style: AppTextStyle.body4.setRegular(),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              onAddressSelected(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}');
            },
            child: const Text('Tambahkan Alamat ini?'),
          ),
        ],
      ),
    );
  }
}
