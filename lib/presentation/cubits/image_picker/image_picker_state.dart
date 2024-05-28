import 'package:image_picker/image_picker.dart';

class ImagePickerState {
  final String? imagePath;
  final XFile? imageFile;

  ImagePickerState({this.imagePath, this.imageFile});

  ImagePickerState copyWith({String? imagePath, XFile? imageFile}) {
    return ImagePickerState(
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
