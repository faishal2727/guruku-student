import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';

class UserInfo extends StatelessWidget {
  final DetailProfileResponse profile;
  const UserInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.id.toString(),
                style: AppTextStyle.body2.setMedium(),
              ),
              Text(
                profile.name.toString(),
                style: AppTextStyle.body2.setMedium(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
