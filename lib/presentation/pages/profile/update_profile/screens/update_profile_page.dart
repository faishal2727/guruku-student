// ignore_for_file: use_super_parameters, library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';
import 'package:guruku_student/presentation/pages/profile/update_profile/widgets/place_mark_update_profile.dart';
import 'package:location/location.dart';

class UpdateProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/update_profile_page';

  final DetailProfileResponse profile;

  const UpdateProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.profile.username ?? 'Data Belum Ada';
    _nameController.text = widget.profile.name ?? 'Data Belum Ada';
    _emailController.text = widget.profile.email ?? 'Data Belum Ada';
    _phoneController.text = widget.profile.phone ?? 'Data Belum Ada';
    _selectedEducation = widget.profile.education ?? _educationOptions.first;
    _addressController.text = widget.profile.address ?? 'Data Belum Ada';
    _birthDateController.text = widget.profile.bod ?? 'Data Belum Ada';
  }

  final GlobalKey<FormState> _updateProfileFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  String? _selectedEducation;
  final List<String> _educationOptions = ['SD', 'SMP', 'SMA', 'SMK'];

  late final Set<Marker> markers = {};
  geo.Placemark? placemark;
  late double selectedLat;
  late double selectedLon;
  final addOnTech = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;

  void _updateProfile() {
    final DateTime? parsedDate = _parseDate(_birthDateController.text);
    if (parsedDate != null) {
      context.read<ProfileBloc>().add(
            OnUpdateProfileEvent(
              username: _usernameController.text,
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              address: _addressController.text,
              education: _selectedEducation ?? '',
              lat: selectedLat.toString(),
              lon: selectedLon.toString(),
              bod: parsedDate,
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Invalid date format",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }

  DateTime? _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  void _submit() {
    if (_updateProfileFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _updateProfile();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Update Profile',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "Gagal Update Data",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Data berhasil diperbarui!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _updateProfileFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    lable: 'Username',
                    key: const Key('username_field'),
                    controller: _usernameController,
                    hintText: 'Masukan Username mu...',
                    labelText: 'Username',
                    marginBottom: 16,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    lable: 'Nama',
                    key: const Key('name_field'),
                    controller: _nameController,
                    hintText: 'Masukan Nama mu...',
                    labelText: 'Nama',
                    marginBottom: 16,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    lable: 'Email',
                    key: const Key('email_field'),
                    controller: _emailController,
                    hintText: 'Masukan Email mu...',
                    labelText: 'Email',
                    marginBottom: 16,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    lable: 'Nomor Hp',
                    key: const Key('phone_field'),
                    controller: _phoneController,
                    hintText: 'Masukan Nomor Hp mu...',
                    labelText: 'Nomor Hp',
                    marginBottom: 16,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor Hp tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  Text(
                    'Pendidikan',
                    style: AppTextStyle.body3.setSemiBold(),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedEducation,
                    decoration: InputDecoration(
                      hintText: 'Pilih Pendidikan mu...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: pr13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: pr13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: _educationOptions.map((String education) {
                      return DropdownMenuItem<String>(
                        value: education,
                        child: Text(education),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedEducation = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pendidikan tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tanggal Lahir',
                    style: AppTextStyle.body3.setSemiBold(),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: pr13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: pr13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    key: const Key('birth_date_field'),
                    controller: _birthDateController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _selectDate(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal Lahir tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
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
                              child: PlacemarkWidgetUpdateProfile(
                                placemark: placemark!,
                                onAddressSelected: (address) {
                                  setState(
                                    () {
                                      _addressController.text = address;
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
                  MyTextFormField(
                    lable: 'Alamat',
                    key: const Key('address_field'),
                    controller: _addressController,
                    hintText: 'Masukan Alamat mu...',
                    labelText: 'Alamat',
                    marginBottom: 16,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: pr11,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 80,
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                _submit();
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary.pr13,
                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: AppTextStyle.body1
                        .setRegular()
                        .copyWith(color: AppColors.primary.pr11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // bottomNavigationBar: Container(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: const Color(0xFF006FD4),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //       ),
      //       onPressed: _submit,
      //       child: Text(
      //         'Update Profile',
      //         style: AppTextStyle.body3.setSemiBold().copyWith(
      //               color: pr11,
      //             ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId(
        "source",
      ),
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
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
      selectedLat = latLng.latitude;
      selectedLon = latLng.longitude;
    });
    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

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
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
      selectedLat = latLng.latitude;
      selectedLon = latLng.longitude;
    });
    defineMarker(latLng, street!, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
