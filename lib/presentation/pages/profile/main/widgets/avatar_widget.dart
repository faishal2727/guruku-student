// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import '../../../../../domain/entity/teacher/detail_profile_response.dart';

class AvatarWidget extends StatelessWidget {
  final DetailProfileResponse profile;

  const AvatarWidget({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: pr13,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              Text(
                profile.username!,
                style: AppTextStyle.heading5
                    .setMedium()
                    .copyWith(color: Colors.white),
              ),
              Text(
                profile.role!,
                style: AppTextStyle.body4
                    .setMedium()
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ],
      ),
    );
  }
}
