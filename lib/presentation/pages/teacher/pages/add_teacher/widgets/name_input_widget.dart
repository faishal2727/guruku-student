import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class NameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const NameInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Guru 🔅',
            style: AppTextStyle.body3.setMedium(),
          ),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Masukkan nama guru...',
            ),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
