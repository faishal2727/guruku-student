// ignore_for_file: constant_identifier_names, prefer_const_declarations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/shared_widgets/not_nearby_teacher.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/banner_home_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_horizontal.dart';
import 'package:guruku_student/presentation/pages/home/widgets/category_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/header_home_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/nearby_teacher_list_widget.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_hirozontal.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';
import 'dart:math' show asin, cos, pi, sin, sqrt;

import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

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

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  double? userLatitude;
  double? userLongitude;

  @override
  void initState() {
    super.initState();
    getUserLocation();
    Future.microtask(() {
      context.read<TeacherBloc>().add(OnTeacherEvent());
      context.read<ProfileBloc>().add(OnProfileEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherBloc>().add(OnTeacherEvent());
    context.read<ProfileBloc>().add(OnProfileEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getUserLocation() async {
    Location location = Location();

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

    LocationData locationData = await location.getLocation();
    setState(() {
      userLatitude = locationData.latitude;
      userLongitude = locationData.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          const HeaderHomeWidget(),
          const SizedBox(height: 16),
          const BannerHomeWidget(),
          const SizedBox(height: 16),
          const CategoryWidget(),
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
                final double maxDistance = 15.0;
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
                    return distance <= maxDistance;
                  } else {
                    return false;
                  }
                }).toList();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Guru Terpopuler',
              style: AppTextStyle.body2.setSemiBold(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: BlocBuilder<TeacherBloc, TeacherState>(
              builder: (context, state) {
                if (state is TeacherLoading) {
                  return const Center(
                    child: ShimmerCardHorizontal(),
                  );
                } else if (state is TeacherHasData) {
                  final result = state.result;
                  return CardTeacherHorizontal(teachers: result);
                } else if (state is TeacherError) {
                  return ErrorSection(
                    isLoading: _isLoading,
                    onPressed: _retry,
                    message: state.message,
                  );
                } else if (state is TeacherEmpty) {
                  return const EmptySection();
                } else {
                  return const Center(
                    child: Text('Error Get Teacher'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}






// BlocBuilder<ProfileBloc, ProfileState>(
          //   builder: (context, state) {
          //     if (state is ProfileLoading) {
          //       return Center(
          //         child: Lottie.asset(
          //           'assets/lotties/loading.json',
          //           height: 200,
          //           width: 200,
          //         ),
          //       );
          //     } else if (state is ProfileHasData) {
          //       final profile = state.result;
          //       return HeaderHomeWidget(
          //         profile: profile,
          //       );
          //     } else if (state is UpdateProfileSuccess) {
          //       Navigator.pop(context);
          //       return const SizedBox();
          //     } else if (state is ProfileEmpty) {
          //       return const EmptySection();
          //     } else if (state is ProfileError) {
          //       return ErrorSection(
          //         isLoading: _isLoading,
          //         onPressed: _retry,
          //         message: state.message,
          //       );
          //     } else {
          //       return const Text(
          //         'unexpected state',
          //         key: Key('unexpected_state_message'),
          //       );
          //     }
          //   },
          // ),