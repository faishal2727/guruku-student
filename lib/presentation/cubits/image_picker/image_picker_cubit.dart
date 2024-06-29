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

  void addPdfPath(String path) {
    final List<String> newPdfPaths = List.from(state.pdfPaths)..add(path);
    emit(state.copyWith(pdfPaths: newPdfPaths));
  }

  void removePdfPath(String path) {
    final List<String> newPdfPaths = List.from(state.pdfPaths)..remove(path);
    emit(state.copyWith(pdfPaths: newPdfPaths));
  }
}

// class ImagePickerCubit extends Cubit<ImagePickerState> {
//   ImagePickerCubit() : super(ImagePickerState());

//   void setImagePath(String? value) {
//     emit(state.copyWith(imagePath: value));
//   }

//   void setImageFile(XFile? value) {
//     emit(state.copyWith(imageFile: value));
//   }
// }

// class FilePickerCubit extends Cubit<FilePickerState> {
//   FilePickerCubit() : super(FilePickerState());

//   void setPDFPath(String? value) {
//     emit(state.copyWith(pdfPath: value));
//   }
// }



