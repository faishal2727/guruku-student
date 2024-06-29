// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/data/datasources/remote/register_teacher_remote_data_source.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/register_teacher/register_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/teacher_landing_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/button_req_teacher.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/step_one_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/step_three_widget.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/step_two_widget.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  int currentStep = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _gelarController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();
  final TextEditingController _tahunLulusController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  String? _selectedEducation;

  void _reqTeacher() async {
    setState(() {
      isLoading = true; // Tampilkan indikator loading
    });

    final cubit = context.read<ImagePickerCubit>();
    final bloc = context.read<RegisterTeacherBloc>();
    final state = cubit.state;
    List<String?> fileUrls = []; // Menyimpan URL semua file yang diunggah

    // Memastikan ada file gambar yang dipilih
    if (state.imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      setState(() {
        isLoading = false; // Sembunyikan indikator loading
      });
      return;
    }

    // Mengunggah file gambar ID (jika ada)
    final imageFile = File(state.imagePath!);
    final imageBytes = await imageFile.readAsBytes();
    final imageName = imageFile.path.split('/').last;

    String? idCardUrl;
    try {
      idCardUrl = await RegisterTeacherRemoteDataSourceImpl(
        client: http.Client(),
      ).uploadImageToCloudinary(imageBytes, imageName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload image to Cloudinary'),
        ),
      );
      setState(() {
        isLoading = false; // Sembunyikan indikator loading
      });
      return;
    }

    // Memproses file PDF
    for (var pdfPath in state.pdfPaths) {
      final fileFile = File(pdfPath);
      final fileBytes = await fileFile.readAsBytes();
      final fileFileName = fileFile.path.split('/').last;

      try {
        // Mengunggah file PDF ke Cloudinary
        final fileUrl = await RegisterTeacherRemoteDataSourceImpl(
          client: http.Client(),
        ).uploadImageToCloudinary(fileBytes, fileFileName);

        // Menyimpan URL file yang diunggah
        fileUrls.add(fileUrl);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload PDF file to Cloudinary'),
          ),
        );
        setState(() {
          isLoading = false; // Sembunyikan indikator loading
        });
        return;
      }
    }
    final fileUrlsString = fileUrls.join(',');

    // Melakukan registrasi guru dengan menggunakan Bloc
    bloc.add(DoRegisterTeacher(
      username: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      education: _educationController.text,
      jurusan: _jurusanController.text,
      tahunLulus: _tahunLulusController.text,
      idCard: idCardUrl,
      file: fileUrlsString,
    ));

    setState(() {
      isLoading = false; // Sembunyikan indikator loading setelah selesai
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Registrasi Guru'),
        backgroundColor: pr11,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: BlocListener<RegisterTeacherBloc, RegisterTeacherState>(
          listener: (context, state) {
            if (state.stateRegister == ReqStateRegisTeacher.error) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.red[400],
                  ),
                );
            } else if (state.stateRegister == ReqStateRegisTeacher.loaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Berhasil Register!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacementNamed(
                  context, TeacherLandingPage.ROUTE_NAME);
            }
          },
          child: Form(
            key: _formKey,
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  children: <Widget>[
                    if (currentStep != 2)
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: const Text('Continue'),
                      ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
              steps: [
                Step(
                  title: const Text(''),
                  isActive: currentStep == 0,
                  content: StepOneWidget(
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    gelarController: _gelarController,
                    jurusanController: _jurusanController,
                    tahunLulusController: _tahunLulusController,
                    educationDetailController: _educationController,
                    selectedEducation: _selectedEducation,
                    onEducationChanged: (String? newValue) {
                      setState(() {
                        _selectedEducation = newValue;
                      });
                    },
                  ),
                ),
                Step(
                  title: const Text(''),
                  isActive: currentStep == 1,
                  content: StepTwoWidget(),
                ),
                Step(
                  title: const Text(''),
                  isActive: currentStep == 2,
                  content: StepThreeWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: currentStep == 2
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonReqTeacher(
                title: 'Kirim',
                onPressed: _reqTeacher,
              ),
            )
          : null,
    );
  }
}
