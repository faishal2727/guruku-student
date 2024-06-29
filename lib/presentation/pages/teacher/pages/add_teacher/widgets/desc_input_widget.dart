import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class DescInputWidget extends StatelessWidget {
  final TextEditingController controller;
  const DescInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: pr11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi Guru 🔅',
            style: AppTextStyle.body3.setMedium(),
          ),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Masukan deskripsi guru . . .',
            ),
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
