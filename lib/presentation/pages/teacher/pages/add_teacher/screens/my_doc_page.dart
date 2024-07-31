// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';


class MyDocPage extends StatefulWidget {
  static const ROUTE_NAME = 'my-doc-page';
  final MyDataTeacherResponse data;
  const MyDocPage({
    super.key,
    required this.data,
  });

  @override
  State<MyDocPage> createState() => _MyDocPageState();
}

class _MyDocPageState extends State<MyDocPage> {
  late final String pdfUrl;

  @override
  void initState() {
    super.initState();
    pdfUrl = widget.data.file.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Text('KTP', style: AppTextStyle.body3.setRegular()),
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   height: 200,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: widget.data.idCard != null
          //       ? ClipRRect(
          //           borderRadius: BorderRadius.circular(12),
          //           child: CachedNetworkImage(
          //             imageUrl: widget.data.idCard!,
          //             fit: BoxFit.fill,
          //             width: double.infinity,
          //             height: double.infinity,
          //             placeholder: (context, url) => Center(
          //               child: Lottie.asset(
          //                 'assets/lotties/loading_state.json',
          //                 height: 200,
          //                 width: 200,
          //               ),
          //             ),
          //             errorWidget: (context, url, error) => const Center(
          //               child: Icon(Icons.error, color: Colors.red),
          //             ),
          //           ),
          //         )
          //       : const Center(
          //           child: Icon(Icons.warning, color: Colors.red),
          //         ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Text('Berkas Anda', style: AppTextStyle.body3.setRegular()),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Text(widget.data.file.toString(), style: AppTextStyle.body3.setRegular()),
          // ),
          Expanded(
            child: pdfUrl.isNotEmpty
                ? PDFView(
                    filePath: pdfUrl,
                  )
                : const Center(
                    child: Icon(Icons.warning, color: Colors.red),
                  ),
          ),
        ],
      ),
    );
  }
}
