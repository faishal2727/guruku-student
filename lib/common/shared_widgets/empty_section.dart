import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class EmptySection extends StatelessWidget {
  const EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty.png',
            width: 450,
            height: 180,
          ),
          const SizedBox(height: 28),
          Text(
            key: const Key('empty_message'),
            'Upps...!!! Data Masih Kosong',
            style: AppTextStyle.body2.setBold(),
          ),
        ],
      ),
    );
  }
}
