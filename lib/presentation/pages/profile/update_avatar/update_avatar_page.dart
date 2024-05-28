// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAvatarPage extends StatefulWidget {
  static const ROUTE_NAME = '/update_avatar';
  const UpdateAvatarPage({super.key});

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Avatar",
          style: AppTextStyle.heading5.setSemiBold().copyWith(
                color: pr11,
              ),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
        actions: [
          IconButton(
            onPressed: () => _onUpload(),
            icon: const Icon(Icons.upload),
            tooltip: "Unggah",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
                builder: (context, state) {
                  return state.imagePath == null
                      ? const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 100,
                          ),
                        )
                      : _showImage(state.imagePath!);
                },
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onGalleryView(),
                    child: const Text("Gallery"),
                  ),
                  ElevatedButton(
                    onPressed: () => _onCameraView(),
                    child: const Text("Camera"),
                  ),
                ],
              ),
            ),
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is UpdateAvatarSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil Meperbarui Avatar'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context, true);
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  _onUpload() async {
    final cubit = context.read<ImagePickerCubit>();
    final profileBloc = context.read<ProfileBloc>();
    final state = cubit.state;

    if (state.imagePath != null) {
      final file = File(state.imagePath!);
      final bytes = await file.readAsBytes();
      final fileName = file.path.split('/').last;

      profileBloc.add(OnUpdateAvatarEvent(bytes: bytes, fileName: fileName));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  _onGalleryView() async {
    final cubit = context.read<ImagePickerCubit>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      cubit.setImageFile(pickedFile);
      cubit.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final cubit = context.read<ImagePickerCubit>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      cubit.setImageFile(pickedFile);
      cubit.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage(String imagePath) {
    return kIsWeb
        ? Image.network(
            imagePath,
            height: 50,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          )
        : Image.file(
            File(imagePath),
            height: 50,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          );
  }
}
