import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_cubit.dart';
import 'package:guruku_student/presentation/cubits/image_picker/image_picker_state.dart';

class StepThreeWidget extends StatefulWidget {
  @override
  _StepThreeWidgetState createState() => _StepThreeWidgetState();
}

class _StepThreeWidgetState extends State<StepThreeWidget> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Upload Dokumen 🔅', style: AppTextStyle.body3.setMedium()),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.pdfPaths.isNotEmpty)
                  ...state.pdfPaths.map((path) => _showPdf(path)).toList(),
                if (state.pdfPaths.length < 5)
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pr13,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _onPdfView(context),
                      child: Text(
                        "Upload PDF",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                Text(
                    'Upload dokumen untuk seperti ijzah kelulusan,sertifikat atau surat keterangan aktif kuliah bagi anda yang masih kuliah',
                    style: AppTextStyle.body4.setRegular()),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onPdfView(BuildContext context) async {
    final cubit = context.read<ImagePickerCubit>();

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Memungkinkan pengguna untuk memilih beberapa file
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      for (var file in result.files) {
        cubit.addPdfPath(
            file.path!); // Menambahkan setiap path file PDF ke dalam state
      }
    }
  }

  Widget _showPdf(String pdfPath) {
    String fileName = pdfPath.split('/').last;
    return Row(
      children: [
        Text(fileName),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            context.read<ImagePickerCubit>().removePdfPath(pdfPath);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
