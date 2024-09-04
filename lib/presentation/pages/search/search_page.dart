// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/teacher_search/teacher_search_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:location/location.dart';
import 'dart:math';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search-teacher';
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double? userLatitude;
  double? userLongitude;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    setState(() {
      userLatitude = locationData.latitude;
      userLongitude = locationData.longitude;
      _isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Cari Guru',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16),
                        onChanged: (name) {
                          context.read<TeacherSearchBloc>().add(OnQueryChanged(name));
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari berdasarkan nama,mapel,jenjang . . .',
                          hintStyle: TextStyle(color: AppColors.neutral.ne05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.primary.pr13,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.primary.pr13,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.primary.pr13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Search Result',
                      style: AppTextStyle.body3.setSemiBold(),
                    ),
                    BlocBuilder<TeacherSearchBloc, TeacherSearchState>(
                      builder: (context, state) {
                        if (state is SearchTeacherLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SearchTeacherHasData) {
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
                            ..sort((a, b) => a.distance!.compareTo(b.distance!)); // Sort by distance
                          if (nearbyTeachers.isEmpty) {
                            return const Center(
                              child: Text('Tidak ada guru terdekat yang ditemukan'),
                            );
                          } else {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (context, index) {
                                  final teacher = nearbyTeachers[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CardTeacherVertical(teacher: teacher),
                                  );
                                },
                                itemCount: nearbyTeachers.length,
                              ),
                            );
                          }
                        } else if (state is SearchTeacherError) {
                          return Center(
                            child: Text(
                              state.message,
                              key: const Key('error_message'),
                            ),
                          );
                        } else if (state is SearchTeacherEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.2,
                              ),
                              const Center(child: Text('Tidak ada guru yang ditemukan')),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
