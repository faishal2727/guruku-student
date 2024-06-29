import 'package:image_picker/image_picker.dart';

class ImagePickerState {
  final String? imagePath;
  final XFile? imageFile;
  final List<String> pdfPaths;

  ImagePickerState({this.imagePath, this.imageFile, List<String>? pdfPaths})
      : pdfPaths = pdfPaths ?? [];

  ImagePickerState copyWith({String? imagePath, XFile? imageFile, List<String>? pdfPaths}) {
    return ImagePickerState(
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
      pdfPaths: pdfPaths ?? this.pdfPaths,
    );
  }
}



// class ImagePickerState {
//   final String? imagePath;
//   final XFile? imageFile;
 

//   ImagePickerState({this.imagePath, this.imageFile});

//   ImagePickerState copyWith({String? imagePath, XFile? imageFile, String? pdfPath}) {
//     return ImagePickerState(
//       imagePath: imagePath ?? this.imagePath,
//       imageFile: imageFile ?? this.imageFile,
//     );
//   }
// }

// class FilePickerState {
//   final String? pdfPath;

//   FilePickerState({this.pdfPath});

//   FilePickerState copyWith({String? pdfPath}) {
//     return FilePickerState(
//       pdfPath: pdfPath ?? this.pdfPath,
//     );
//   }
// }
