// ignore_for_file: constant_identifier_names, use_build_context_synchronously, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:guruku_student/data/datasources/remote/register_teacher_remote_data_source.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/add_data_teacher/add_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/my_data_teacher/my_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/button_add_data.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/category_input_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/desc_input_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/experience_input_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/name_input_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/price_input_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/teacher_map_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/widgets/teacher_photo_widget.dart';
import 'package:http/http.dart' as http;

class TeacherPage extends StatefulWidget {
  static const ROUTE_NAME = "/teacher-page";
  final MyDataTeacherResponse data;
  const TeacherPage({
    super.key,
    required this.data,
  });

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherCatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data.name ?? '';
    _descController.text = widget.data.description ?? '';
    _priceController.text = widget.data.price ?? '';
    _timeController.text = widget.data.timeExperience ?? '';
    _addressController.text = widget.data.address ?? '';
    _otherCatController.text = widget.data.typeTeaching ?? '';
    if (widget.data.lat != null && widget.data.lon != null) {
      _selectedLat = double.tryParse(widget.data.lat!) ?? 0.0;
      _selectedLon = double.tryParse(widget.data.lon!) ?? 0.0;
    }
    Future.microtask(() {
      context
          .read<MyDataTeacherBloc>()
          .add(OnMyDataTeacherEvent(widget.data.id));
    });
  }

  String _selectedCategory = 'IPA';
  bool _isOtherCategory = false;
  late final Set<Marker> markers = {};
  geo.Placemark? placemark;
  double _selectedLat = 0.0;
  double _selectedLon = 0.0;

  final addOnTech = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;

  void _addData() async {
    final cubit = context.read<ImagePickerCubit>();
    final bloc = context.read<AddDataTeacherBloc>();
    final state = cubit.state;

    String? imageUrl;
    if (state.imageFile != null) {
      final file = File(state.imagePath!);
      final bytes = await file.readAsBytes();
      final fileName = file.path.split('/').last;

      try {
        imageUrl =
            await RegisterTeacherRemoteDataSourceImpl(client: http.Client())
                .uploadImageToCloudinary(bytes, fileName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image to Cloudinary')),
        );
        return;
      }
    } else if (widget.data.picture != null && widget.data.picture!.isNotEmpty) {
      imageUrl = widget.data.picture!;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }
    final category = _selectedCategory == 'lainnya'
        ? _otherCatController.text
        : _selectedCategory;

    bloc.add(
      OnAddDataTeacher(
        picture: imageUrl,
        name: _nameController.text,
        desc: _descController.text,
        typeTeaching: category,
        price: _priceController.text,
        timeExperience: _timeController.text,
        lat: _selectedLat.toString(),
        lon: _selectedLon.toString(),
        address: _addressController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pr11,
      appBar: AppBar(
        title: Text(
          'Data Guru',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocListener<AddDataTeacherBloc, AddDataTeacherState>(
        listener: (context, state) {
          if (state.state == ReqStateTeacher.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "Gagal",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.state == ReqStateTeacher.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: pr11,
                width: MediaQuery.of(context).size.width,
                child: TeacherPhotoWidget(data: widget.data),
              ),
              Divider(thickness: 10, color: pr16),
              NameInputWidget(controller: _nameController),
              Divider(thickness: 10, color: pr16),
              DescInputWidget(controller: _descController),
              Divider(thickness: 10, color: pr16),
              Container(
                padding: const EdgeInsets.all(16),
                color: pr11,
                child: Column(
                  children: [
                    CategoryInputWidget(
                      initialCategory: _selectedCategory,
                      otherCategoryController: _otherCatController,
                      onChanged: (String category) {
                        setState(() {
                          _selectedCategory = category;
                          _isOtherCategory = _selectedCategory == 'lainnya';
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    PriceInputWidget(controller: _priceController),
                    const SizedBox(height: 16),
                    ExperienceInputWidget(controller: _timeController),
                  ],
                ),
              ),
              Divider(thickness: 10, color: pr16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Masukan Alamat 🔅',
                    style: AppTextStyle.body3.setMedium()),
              ),
              TeacherMapWidget(
                addressController: _addressController,
                onLocationChanged: (LatLng latLng) {
                  setState(() {
                    _selectedLat = latLng.latitude;
                    _selectedLon = latLng.longitude;
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 1,
          ),
          ButtonAddData(
            onPressed: _addData,
            title: 'Simpan',
          ),
        ],
      ),
    );
  }
}
