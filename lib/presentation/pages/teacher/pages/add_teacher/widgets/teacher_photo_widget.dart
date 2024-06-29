// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

class TeacherPhotoWidget extends StatelessWidget {
  final MyDataTeacherResponse data;

  const TeacherPhotoWidget({
    Key? key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Foto Guru 🔅',
              style: AppTextStyle.body3.setMedium(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, state) {
            if (data.picture != null && data.picture!.isNotEmpty) {
              return _showNetworkImage(data.picture!);
            } else if (state.imagePath != null) {
              return _showImage(state.imagePath!);
            } else {
              return const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.image,
                  size: 150,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => _onGalleryView(context),
          child: const Text(
            "Gallery",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _showNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 150,
      width: 150,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 150,
      ),
    );
  }

  Widget _showImage(String imagePath) {
    return Image.file(
      File(imagePath),
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
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
}
