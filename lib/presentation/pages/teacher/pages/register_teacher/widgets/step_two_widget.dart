// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_state.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/camera_widget.dart';
import 'package:image_picker/image_picker.dart';

class StepTwoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Upload KTP 🔅', style: AppTextStyle.body3.setMedium()),
            const SizedBox(height: 16),
            Center(
              child: state.imagePath == null
                  ? Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset(
                          'assets/images/icon-ktp.png',
                          width: 300,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : _showImage(state.imagePath!),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pr13,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _onGalleryView(context),
                  child: Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pr13,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _onCustomCameraView(context),
                  child: Text(
                    "Kamera",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  Future<void> _onCustomCameraView(BuildContext context) async {
    final cubit = context.read<ImagePickerCubit>();
    final navigator = Navigator.of(context);

    final cameras = await availableCameras();

    final XFile? resultImageFile = await navigator.push(
      MaterialPageRoute(
        builder: (context) => CameraWidget(
          cameras: cameras,
        ),
      ),
    );

    if (resultImageFile != null) {
      cubit.setImageFile(resultImageFile);
      cubit.setImagePath(resultImageFile.path);
    }
  }

  void _onGalleryView(BuildContext context) async {
    final cubit = context.read<ImagePickerCubit>();

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      cubit.setImageFile(pickedFile);
      cubit.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage(String imagePath) {
    return Image.file(
      File(imagePath),
      height: 200,
      width: 300,
      fit: BoxFit.cover,
    );
  }
}
