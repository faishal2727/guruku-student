import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerState());

  void setImagePath(String? value) {
    emit(state.copyWith(imagePath: value));
  }

  void setImageFile(XFile? value) {
    emit(state.copyWith(imageFile: value));
  }
}
