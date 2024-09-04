// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guruku_student/common/shared_widgets/not_nearby_teacher.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/banner_home_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/header_home_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/nearby_teacher_list_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';
import 'dart:math' show asin, cos, pi, sin, sqrt;

import 'package:location/location.dart' as g;
import 'package:location/location.dart';

// Function to calculate distance between two coordinates using Haversine formula
double calculateDistance(double startLatitude, double startLongitude,
    double endLatitude, double endLongitude) {
  const double radiusOfEarth = 6371;
  final double latDistance = degreesToRadians(endLatitude - startLatitude);
  final double lonDistance = degreesToRadians(endLongitude - startLongitude);
  final double a = sin(latDistance / 2) * sin(latDistance / 2) +
      cos(degreesToRadians(startLatitude)) *
          cos(degreesToRadians(endLatitude)) *
          sin(lonDistance / 2) *
          sin(lonDistance / 2);
  final double c = 2 * asin(sqrt(a));
  final double distance = radiusOfEarth * c;
  return distance;
}

// Function to convert degrees to radians
double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

// Function to get address from latitude and longitude
Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  } catch (e) {
    return 'Tidak dapat menemukan lokasi';
  }
}

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  double? userLatitude;
  double? userLongitude;
  String userAddress = 'Mencari lokasi...';

  @override
  void initState() {
    super.initState();
    getUserLocation();
    Future.microtask(() {
      context.read<TeacherBloc>().add(OnTeacherEvent());
      context.read<ProfileBloc>().add(OnProfileEvent());
    });
  }

  Future<void> getUserLocation() async {
    g.Location location = g.Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    g.LocationData locationData = await location.getLocation();
    setState(() {
      userLatitude = locationData.latitude;
      userLongitude = locationData.longitude;
    });

    if (userLatitude != null && userLongitude != null) {
      String address =
          await getAddressFromLatLng(userLatitude!, userLongitude!);
      setState(() {
        userAddress = address;
      });
    }
  }

  void updateLocation(double latitude, double longitude, String address) {
    setState(() {
      userLatitude = latitude;
      userLongitude = longitude;
      userAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // ElevatedButton(
          //   style: ButtonStyle(
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Colors.green)),
          //   child: Text('I Am  buggy'),
          //   onPressed: () {
          //     throw new StateError('HALO GUYS INI COBA ERROR');
          //   },
          // ),
          HeaderHomeWidget(
            userLatitude: userLatitude,
            userLongitude: userLongitude,
            userAddress: userAddress,
            onLocationChanged: (latitude, longitude, address) {
              updateLocation(latitude, longitude, address);
            },
          ),
          const BannerHomeWidget(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Guru Terdekat',
              style: AppTextStyle.body2.setSemiBold(),
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<TeacherBloc, TeacherState>(
            builder: (context, state) {
              if (state is TeacherLoading) {
                return const Center(
                  child: CardShimmerVertical(),
                );
              } else if (state is TeacherHasData) {
                final result = state.result;
                final double maxDistance = 10.0;
                final nearbyTeachers = result.where((teacher) {
                  final double teacherLatitude =
                      double.parse(teacher.lat ?? '0.0');
                  final double teacherLongitude =
                      double.parse(teacher.lon ?? '0.0');
                  if (userLatitude != null && userLongitude != null) {
                    final double distance = calculateDistance(
                      userLatitude!,
                      userLongitude!,
                      teacherLatitude,
                      teacherLongitude,
                    );
                    teacher.distance = distance; // Add distance to teacher
                    return distance <= maxDistance;
                  } else {
                    return false;
                  }
                }).toList()
                  ..sort((a, b) =>
                      a.distance!.compareTo(b.distance!)); // Sort by distance
                if (nearbyTeachers.isEmpty) {
                  return const NotNearbyTeacher();
                } else {
                  return NearbyTeachersListWidget(teachers: nearbyTeachers);
                }
              } else if (state is TeacherError) {
                return Center(
                  key: const Key('error_message_nearby'),
                  child: Text(state.message),
                );
              } else if (state is TeacherEmpty) {
                return const Center(
                  child: Text(
                    'No nearby teachers found',
                    key: Key('empty_message_nearby'),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Error fetching nearby teachers'),
                );
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
