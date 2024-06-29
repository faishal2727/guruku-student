
import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class NotNearbyTeacher extends StatelessWidget {
  const NotNearbyTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/not-loc.png',
            width: 450,
            height: 180,
          ),
          const SizedBox(height: 28),
          Column(
            children: [
              Text(
                key: const Key('empty_message'),
                'Upps...!!! Sepertinya tidak',
                style: AppTextStyle.body2.setBold(),
              ),
              Text(
                key: const Key('empty_message_2'),
                'ada guru didekat kamu',
                style: AppTextStyle.body2.setBold(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
