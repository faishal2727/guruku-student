// ignore_for_file: unused_shown_name, use_super_parameters, library_private_types_in_public_api, constant_identifier_names

import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:guruku_student/presentation/pages/maps/nearby_teacher_list_page.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' as lt;

class MapsPage extends StatefulWidget {
  static const ROUTE_NAME = '/maps_page';
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  bool _isLoading = false;
  final addOnTech = const LatLng(-6.879704, 109.125595);
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};
  bool isMarkerClicked = false;
  late Teacher? selectedTeacher;
  MapType selectedMapType = MapType.normal;
  List<Teacher> teachersWithinRadius = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TeacherBloc>(context).add(OnTeacherEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherBloc>().add(OnTeacherEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Guru Terdekat',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        centerTitle: true,
        backgroundColor: pr13,
      ),
      body: Center(
        child: BlocBuilder<TeacherBloc, TeacherState>(
          builder: (context, state) {
            if (state is TeacherLoading) {
              return Center(
                child: lt.Lottie.asset(
                  'assets/lotties/loading.json',
                  height: 200,
                  width: 200,
                ),
              );
            } else if (state is TeacherHasData) {
              return buildMapWithMarkers(state.result);
            } else if (state is TeacherError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMapWithMarkers(List<Teacher> teachers) {
    markers.clear();
    for (final teacher in teachers) {
      final marker = Marker(
        markerId: MarkerId(teacher.id.toString()),
        position: LatLng(double.parse(teacher.lat ?? '0.0'),
            double.parse(teacher.lon ?? '0.0')),
        onTap: () {
          setState(() {
            isMarkerClicked = true;
            selectedTeacher = teacher;
          });
        },
      );
      markers.add(marker);
    }

    return Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          mapType: selectedMapType,
          markers: markers,
          circles: circles,
          initialCameraPosition: CameraPosition(
            target: addOnTech,
            zoom: 10,
          ),
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          onTap: (_) {
            setState(() {
              isMarkerClicked = false;
              selectedTeacher = null;
            });
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NearbyTeachersListPage(
                    nearbyTeachers: teachersWithinRadius,
                  ),
                ),
              );
            },
            child: const Icon(Icons.wallet),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(8),
            child: Center(
              child: isMarkerClicked && selectedTeacher != null
                  ? CardTeacherVertical(
                      teacher: selectedTeacher!,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  onMyLocationButtonPress();
                },
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoom-in',
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.zoomIn(),
                  );
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoom-out',
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.zoomOut(),
                  );
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                onPressed: null,
                child: PopupMenuButton<MapType>(
                  onSelected: (MapType item) {
                    setState(() {
                      selectedMapType = item;
                    });
                  },
                  offset: const Offset(0, 54),
                  icon: const Icon(Icons.layers_outlined),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<MapType>>[
                    const PopupMenuItem<MapType>(
                      value: MapType.normal,
                      child: Text('Normal'),
                    ),
                    const PopupMenuItem<MapType>(
                      value: MapType.satellite,
                      child: Text('Satellite'),
                    ),
                    const PopupMenuItem<MapType>(
                      value: MapType.terrain,
                      child: Text('Terrain'),
                    ),
                    const PopupMenuItem<MapType>(
                      value: MapType.hybrid,
                      child: Text('Hybrid'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.amber,
                  size: 35,
                ),
                const SizedBox(width: 8),
                Text(
                  'Untuk melihat guru dengan \njarak kurang dari 15 Km \ndari posisi anda sekarang, \nKlik Button Paling Atas',
                  style: AppTextStyle.body3.setMedium(),
                ),
              ],
            ),
          ),
        ),
        // wow
      ],
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
    defineMarker(latLng);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );

    // Filter and update teachers within 15km
    final TeacherState currentState =
        BlocProvider.of<TeacherBloc>(context).state;
    if (currentState is TeacherHasData) {
      final List<Teacher> teachers = currentState.result;
      final List<Teacher> teachersWithinRadius = [];
      for (final teacher in teachers) {
        final double distance = getDistance(
          latLng.latitude,
          latLng.longitude,
          double.parse(teacher.lat ?? '0.0'),
          double.parse(teacher.lon ?? '0.0'),
        );
        if (distance <= 15.0) {
          teachersWithinRadius.add(teacher);
        }
      }
      setState(() {
        this.teachersWithinRadius = teachersWithinRadius;
      });
    }

    // Clear previous circles and add new circle
    setState(() {
      circles.clear();
      circles.add(
        Circle(
          circleId: const CircleId("radius"),
          center: latLng,
          radius: 15000,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.3),
        ),
      );
    });
  }

  void defineMarker(LatLng latLng) {
    final markerK = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
    );

    setState(() {
      markers.clear();
      markers.add(markerK);
    });
  }

  double getDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const int radiusOfEarth = 6371; // Radius bumi dalam kilometer
    final double latDistance = degreesToRadians(endLatitude - startLatitude);
    final double lonDistance = degreesToRadians(endLongitude - startLongitude);
    final double a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(degreesToRadians(startLatitude)) *
            cos(degreesToRadians(endLatitude)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = radiusOfEarth * c;
    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

  // Positioned(
        //   top: 80,
        //   left: 16,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text(
        //         'Teachers Within 15km:',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(
        //         height: 160,
        //         width: 200,
        //         child: ListView.builder(
        //           itemCount: teachersWithinRadius.length,
        //           itemBuilder: (context, index) {
        //             final teacher = teachersWithinRadius[index];
        //             return ListTile(
        //               title: Text(teacher.name ?? ''),
        //               subtitle: Text(teacher.typeTeaching ?? ''),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
